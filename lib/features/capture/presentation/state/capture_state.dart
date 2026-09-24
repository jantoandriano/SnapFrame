import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/core/result/app_exception.dart';
import 'package:snapframe/features/capture/presentation/state/capture_effect.dart';
import 'package:snapframe/features/capture/presentation/state/capture_phase.dart';
import 'package:snapframe/features/frames/domain/frame.dart';

part 'capture_state.freezed.dart';

@freezed
abstract class CaptureState with _$CaptureState {
  const factory CaptureState({
    required Frame frame,
    required int currentSlotIndex,
    required List<XFile?> captures,
    required CapturePhase phase,
    required CameraLensDirection cameraLens,
    AppException? error,
    CaptureEffect? effect,
  }) = _CaptureState;
}
