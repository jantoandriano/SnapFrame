import 'package:camera/camera.dart';

/// One-shot signals the view consumes via `ref.listen`, then clears.
sealed class CaptureEffect {
  const CaptureEffect();
}

/// All slots captured — hand the photos off to Review/Retake.
class CaptureFinishedEffect extends CaptureEffect {
  const CaptureFinishedEffect(this.photos);
  final List<XFile> photos;
}

/// A single retake finished — hand the one new photo back to the caller.
class RetakeFinishedEffect extends CaptureEffect {
  const RetakeFinishedEffect(this.slotIndex, this.photo);
  final int slotIndex;
  final XFile photo;
}
