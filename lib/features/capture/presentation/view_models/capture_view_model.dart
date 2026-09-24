import 'dart:async';

import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:snapframe/core/utils/haptics.dart';
import 'package:snapframe/features/capture/data/capture_providers.dart';
import 'package:snapframe/features/capture/domain/capture_repository.dart';
import 'package:snapframe/features/capture/presentation/state/capture_effect.dart';
import 'package:snapframe/features/capture/presentation/state/capture_phase.dart';
import 'package:snapframe/features/capture/presentation/state/capture_state.dart';
import 'package:snapframe/features/frames/domain/frame.dart';

part 'capture_view_model.g.dart';

@riverpod
class CaptureViewModel extends _$CaptureViewModel {
  late final CaptureRepository _repo;
  Timer? _countdownTimer;

  @override
  CaptureState build(Frame frame, {int? retakeSlotIndex}) {
    _repo = ref.watch(captureRepositoryProvider);
    ref.onDispose(() {
      _countdownTimer?.cancel();
      unawaited(_repo.disposeCamera());
    });

    // `build()` hasn't returned yet, so `state` isn't readable — pass the
    // lens explicitly instead of letting `_initCamera` read it off `state`.
    unawaited(_initCamera(CameraLensDirection.front));

    return CaptureState(
      frame: frame,
      currentSlotIndex: retakeSlotIndex ?? 0,
      captures: List<XFile?>.filled(frame.slots.length, null),
      phase: const CapturePhase.idle(),
      cameraLens: CameraLensDirection.front,
    );
  }

  /// Exposed for the view's `CameraPreview` widget — not part of the
  /// equatable state, since a live platform controller has no value
  /// equality worth diffing on.
  CameraController? get cameraController => _repo.cameraController;

  Future<void> _initCamera(CameraLensDirection lens) async {
    final result = await _repo.initializeCamera(lens);
    result.when(
      success: (_) {
        state = state.copyWith(error: null);
        _startCountdown();
      },
      failure: (e) => state = state.copyWith(error: e),
    );
  }

  void _startCountdown() => _tickCountdown(state.frame.countdownSec);

  void _tickCountdown(int remaining) {
    _countdownTimer?.cancel();
    if (remaining <= 0) {
      Haptics.heavy();
      state = state.copyWith(phase: const CapturePhase.capturing());
      unawaited(_capture());
      return;
    }
    Haptics.medium();
    state = state.copyWith(phase: CapturePhase.countingDown(remaining));
    _countdownTimer = Timer(
      const Duration(seconds: 1),
      () => _tickCountdown(remaining - 1),
    );
  }

  Future<void> _capture() async {
    final result = await _repo.takePicture();
    await result.when(
      success: (photo) async {
        final updated = [...state.captures];
        updated[state.currentSlotIndex] = photo;
        state = state.copyWith(captures: updated);
        await _advance();
      },
      failure: (e) async {
        state = state.copyWith(error: e, phase: const CapturePhase.idle());
      },
    );
  }

  Future<void> _advance() async {
    if (retakeSlotIndex != null) {
      state = state.copyWith(
        phase: const CapturePhase.done(),
        effect: RetakeFinishedEffect(
          state.currentSlotIndex,
          state.captures[state.currentSlotIndex]!,
        ),
      );
      return;
    }

    final nextIndex = state.currentSlotIndex + 1;
    if (nextIndex >= state.frame.slots.length) {
      state = state.copyWith(
        phase: const CapturePhase.done(),
        effect: CaptureFinishedEffect(state.captures.cast<XFile>()),
      );
      return;
    }

    state = state.copyWith(currentSlotIndex: nextIndex);
    _startCountdown();
  }

  void onLensTogglePressed() {
    final next = state.cameraLens == CameraLensDirection.front
        ? CameraLensDirection.back
        : CameraLensDirection.front;
    state = state.copyWith(cameraLens: next);
    unawaited(_repo.initializeCamera(next));
  }

  void onRetryPressed() {
    state = state.copyWith(error: null);
    unawaited(_initCamera(state.cameraLens));
  }

  void clearEffect() => state = state.copyWith(effect: null);

  Future<void> onAppPaused() async {
    _countdownTimer?.cancel();
    await _repo.disposeCamera();
  }

  Future<void> onAppResumed() async {
    if (state.phase is CaptureDone) return;
    await _initCamera(state.cameraLens);
  }
}
