import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/capture/data/capture_providers.dart';
import 'package:snapframe/features/capture/domain/capture_repository.dart';
import 'package:snapframe/features/capture/presentation/state/capture_effect.dart';
import 'package:snapframe/features/capture/presentation/state/capture_phase.dart';
import 'package:snapframe/features/capture/presentation/view_models/capture_view_model.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/frame_status.dart';
import 'package:snapframe/features/frames/domain/frame_visibility.dart';
import 'package:snapframe/features/frames/domain/slot.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

class _MockCaptureRepository extends Mock implements CaptureRepository {}

Frame _testFrame({int countdownSec = 1, int slotCount = 2}) {
  return Frame(
    id: 'test',
    title: 'test frame',
    ownerId: 'test',
    isOfficial: false,
    visibility: FrameVisibility.private,
    tier: Tier.free,
    overlayPath: 'assets/frames/sample_overlay.png',
    thumbnailPath: 'assets/frames/sample_overlay.png',
    width: 100,
    height: 100,
    slots: List.generate(slotCount, (_) => const Slot(x: 0, y: 0, w: 1, h: 1)),
    countdownSec: countdownSec,
    status: FrameStatus.approved,
    usageCount: 0,
    reportCount: 0,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  );
}

void main() {
  // Haptics calls go through a MethodChannel, which needs a binding even
  // though this is a plain (non-widget) test.
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockCaptureRepository repo;
  late ProviderContainer container;
  final frame = _testFrame();

  setUpAll(() {
    registerFallbackValue(CameraLensDirection.front);
  });

  setUp(() {
    repo = _MockCaptureRepository();
    when(() => repo.initializeCamera(any()))
        .thenAnswer((_) async => const Result.success(null));
    when(() => repo.disposeCamera()).thenAnswer((_) async {});
    container = ProviderContainer(
      overrides: [captureRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  // `@riverpod` providers are autoDispose by default: with no active
  // listener, each `container.read()` independently builds and tears the
  // provider down again, so a bare `read()` can't observe async state
  // updates that land after the read returns. `container.listen(...)`
  // holds it alive for the rest of the test, same as a widget's
  // `ref.watch` would in the real app.
  void keepAlive(CaptureViewModelProvider provider) {
    container.listen(provider, (_, _) {});
  }

  test('captures every slot in sequence, then reports all photos', () async {
    var takeCount = 0;
    when(() => repo.takePicture()).thenAnswer((_) async {
      takeCount++;
      return Result.success(XFile.fromData(Uint8List(0), name: 'p$takeCount'));
    });

    final provider = captureViewModelProvider(frame);
    keepAlive(provider);

    await Future<void>.delayed(const Duration(milliseconds: 100));
    expect(container.read(provider).phase, const CapturePhase.countingDown(1));

    // 2 slots × (1s countdown + 1s "got it" hold), plus slack.
    await Future<void>.delayed(const Duration(seconds: 5));

    final state = container.read(provider);
    expect(state.phase, const CapturePhase.done());
    expect(state.captures.every((c) => c != null), isTrue);
    expect(state.effect, isA<CaptureFinishedEffect>());
    expect((state.effect! as CaptureFinishedEffect).photos, hasLength(2));
  });

  test('holds on the captured photo before the next countdown', () async {
    final photo = XFile.fromData(Uint8List(0), name: 'p1');
    when(() => repo.takePicture())
        .thenAnswer((_) async => Result.success(photo));

    final provider = captureViewModelProvider(frame);
    keepAlive(provider);

    // Past the 1s countdown, inside the hold.
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    var state = container.read(provider);
    expect(state.phase, CapturePhase.captured(photo));
    expect(state.currentSlotIndex, 0);

    // Hold over: on to the second slot's countdown.
    await Future<void>.delayed(capturedHoldDuration);
    state = container.read(provider);
    expect(state.currentSlotIndex, 1);
    expect(state.phase, isA<CaptureCountingDown>());
  });

  test('retake mode captures only the requested slot', () async {
    when(() => repo.takePicture())
        .thenAnswer((_) async => Result.success(XFile.fromData(Uint8List(0))));

    final provider = captureViewModelProvider(frame, retakeSlotIndex: 1);
    keepAlive(provider);

    // 1s countdown + 1s hold, plus slack.
    await Future<void>.delayed(const Duration(seconds: 3));

    final state = container.read(provider);
    expect(state.phase, const CapturePhase.done());
    expect(state.currentSlotIndex, 1);
    expect(state.effect, isA<RetakeFinishedEffect>());
    expect((state.effect! as RetakeFinishedEffect).slotIndex, 1);
  });

  test('shows an error and stays idle when camera init fails', () async {
    when(() => repo.initializeCamera(any())).thenAnswer(
      (_) async => const Result.failure(PermissionDeniedException('nope')),
    );

    final provider = captureViewModelProvider(frame);
    keepAlive(provider);

    await Future<void>.delayed(const Duration(milliseconds: 100));

    final state = container.read(provider);
    expect(state.error, isA<PermissionDeniedException>());
    expect(state.phase, const CapturePhase.idle());
  });
}
