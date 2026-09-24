import 'dart:ui';

/// The source-image rect to crop (centered) so that, once scaled to fill
/// [destSize], the image covers it edge-to-edge with no distortion and no
/// letterboxing — the same behavior as CSS `object-fit: cover`.
Rect coverCropSourceRect(Size sourceSize, Size destSize) {
  final sourceAspect = sourceSize.width / sourceSize.height;
  final destAspect = destSize.width / destSize.height;

  final double cropWidth;
  final double cropHeight;
  if (sourceAspect > destAspect) {
    cropHeight = sourceSize.height;
    cropWidth = cropHeight * destAspect;
  } else {
    cropWidth = sourceSize.width;
    cropHeight = cropWidth / destAspect;
  }

  return Rect.fromLTWH(
    (sourceSize.width - cropWidth) / 2,
    (sourceSize.height - cropHeight) / 2,
    cropWidth,
    cropHeight,
  );
}
