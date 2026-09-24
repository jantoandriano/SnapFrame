import 'dart:ui';

/// Pixel-space layout for the bundled sample overlay. Both the one-off
/// generator (`tool/generate_sample_frame.dart`) and `sampleFrame` read
/// from here, so the drawn cutouts and the normalized `Slot` rects can
/// never drift apart.
const double sampleOverlayWidth = 1080;
const double sampleOverlayHeight = 1350;

const List<Rect> sampleOverlaySlotRects = [
  Rect.fromLTWH(90, 70, 900, 330),
  Rect.fromLTWH(90, 420, 900, 330),
  Rect.fromLTWH(90, 770, 900, 330),
];

const double sampleOverlaySlotCornerRadius = 20;
const double sampleOverlayBorderWidth = 18;
const double sampleOverlaySlotBorderWidth = 10;
