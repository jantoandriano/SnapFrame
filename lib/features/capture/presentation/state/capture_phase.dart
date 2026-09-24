import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'capture_phase.freezed.dart';

@freezed
sealed class CapturePhase with _$CapturePhase {
  const factory CapturePhase.idle() = CaptureIdle;
  const factory CapturePhase.countingDown(int n) = CaptureCountingDown;
  const factory CapturePhase.capturing() = CaptureCapturing;

  /// The shot just landed — held briefly so the view can confirm it
  /// before the next countdown (or the hand-off to Review) starts.
  const factory CapturePhase.captured(XFile photo) = CaptureCaptured;
  const factory CapturePhase.done() = CaptureDone;
}
