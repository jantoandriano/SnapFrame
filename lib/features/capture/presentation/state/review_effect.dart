import 'dart:typed_data';

sealed class ReviewEffect {
  const ReviewEffect();
}

/// User tapped a slot — the view owns navigation, so it pushes the retake
/// route and reports the result back via `onRetakeCompleted`.
class RequestRetakeEffect extends ReviewEffect {
  const RequestRetakeEffect(this.slotIndex);
  final int slotIndex;
}

/// A retake landed and the preview has been recomposed with it.
class SlotUpdatedEffect extends ReviewEffect {
  const SlotUpdatedEffect(this.slotIndex);
  final int slotIndex;
}

/// Happy with the preview — hand the composited JPEG to the Result screen.
class ProceedToResultEffect extends ReviewEffect {
  const ProceedToResultEffect(this.jpegBytes);
  final Uint8List jpegBytes;
}
