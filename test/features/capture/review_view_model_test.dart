import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/core/result/result.dart';
import 'package:snapframe/features/capture/presentation/state/review_effect.dart';
import 'package:snapframe/features/capture/presentation/view_models/review_view_model.dart';
import 'package:snapframe/features/frames/data/sample_frame.dart';
import 'package:snapframe/features/result/data/result_providers.dart';
import 'package:snapframe/features/result/domain/compositor_repository.dart';

class _MockCompositorRepository extends Mock implements CompositorRepository {}

void main() {
  late _MockCompositorRepository repo;
  late ProviderContainer container;
  final captures = [
    XFile.fromData(Uint8List(0), name: 'a'),
    XFile.fromData(Uint8List(0), name: 'b'),
    XFile.fromData(Uint8List(0), name: 'c'),
  ];

  setUpAll(() {
    registerFallbackValue(sampleFrame);
    registerFallbackValue(<XFile>[]);
  });

  setUp(() {
    repo = _MockCompositorRepository();
    container = ProviderContainer(
      overrides: [compositorRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  test('composes on build and exposes the preview JPEG', () async {
    final jpeg = Uint8List.fromList([1, 2, 3]);
    when(
      () => repo.compose(
        frame: any(named: 'frame'),
        photos: any(named: 'photos'),
      ),
    ).thenAnswer((_) async => Result.success(jpeg));

    final provider = reviewViewModelProvider(sampleFrame, captures);
    container.listen(provider, (_, _) {});

    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(provider);
    expect(state.isComposing, isFalse);
    expect(state.previewJpeg, jpeg);
  });

  test('onSlotTapped requests a retake for that slot', () async {
    when(
      () => repo.compose(
        frame: any(named: 'frame'),
        photos: any(named: 'photos'),
      ),
    ).thenAnswer((_) async => Result.success(Uint8List(0)));

    final provider = reviewViewModelProvider(sampleFrame, captures);
    container.listen(provider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    container.read(provider.notifier).onSlotTapped(1);

    final state = container.read(provider);
    expect(state.effect, isA<RequestRetakeEffect>());
    expect((state.effect! as RequestRetakeEffect).slotIndex, 1);
  });

  test('onRetakeCompleted swaps the photo in and recomposes', () async {
    final firstJpeg = Uint8List.fromList([1]);
    final secondJpeg = Uint8List.fromList([2]);
    var composeCount = 0;
    when(
      () => repo.compose(
        frame: any(named: 'frame'),
        photos: any(named: 'photos'),
      ),
    ).thenAnswer((_) async {
      composeCount++;
      return Result.success(composeCount == 1 ? firstJpeg : secondJpeg);
    });

    final provider = reviewViewModelProvider(sampleFrame, captures);
    container.listen(provider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final retaken = XFile.fromData(Uint8List(0), name: 'retaken');
    await container.read(provider.notifier).onRetakeCompleted(1, retaken);

    final state = container.read(provider);
    expect(state.captures[1], retaken);
    expect(state.previewJpeg, secondJpeg);
    expect(composeCount, 2);
    expect(state.updatedSlotIndex, 1);
    expect(state.effect, isA<SlotUpdatedEffect>());
    expect((state.effect! as SlotUpdatedEffect).slotIndex, 1);
  });

  test('a failed recompose after retake flags no slot as updated', () async {
    var composeCount = 0;
    when(
      () => repo.compose(
        frame: any(named: 'frame'),
        photos: any(named: 'photos'),
      ),
    ).thenAnswer((_) async {
      composeCount++;
      return composeCount == 1
          ? Result.success(Uint8List(0))
          : const Result.failure(UnknownException('boom'));
    });

    final provider = reviewViewModelProvider(sampleFrame, captures);
    container.listen(provider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    await container
        .read(provider.notifier)
        .onRetakeCompleted(0, XFile.fromData(Uint8List(0)));

    final state = container.read(provider);
    expect(state.isComposing, isFalse);
    expect(state.error, isA<UnknownException>());
    expect(state.updatedSlotIndex, isNull);
    expect(state.effect, isNull);
  });

  test('onContinuePressed hands the composited JPEG off via effect', () async {
    final jpeg = Uint8List.fromList([9, 9]);
    when(
      () => repo.compose(
        frame: any(named: 'frame'),
        photos: any(named: 'photos'),
      ),
    ).thenAnswer((_) async => Result.success(jpeg));

    final provider = reviewViewModelProvider(sampleFrame, captures);
    container.listen(provider, (_, _) {});
    await Future<void>.delayed(const Duration(milliseconds: 50));

    container.read(provider.notifier).onContinuePressed();

    final state = container.read(provider);
    expect(state.effect, isA<ProceedToResultEffect>());
    expect((state.effect! as ProceedToResultEffect).jpegBytes, jpeg);
  });
}
