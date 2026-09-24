import 'package:freezed_annotation/freezed_annotation.dart';

part 'capture_phase.freezed.dart';

@freezed
sealed class CapturePhase with _$CapturePhase {
  const factory CapturePhase.idle() = CaptureIdle;
  const factory CapturePhase.countingDown(int n) = CaptureCountingDown;
  const factory CapturePhase.capturing() = CaptureCapturing;
  const factory CapturePhase.done() = CaptureDone;
}
