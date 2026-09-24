import 'dart:ui';

/// Pixel-space layout for the bundled "photo dump" overlay — a 2×2 grid of
/// polaroid cards. Shared by the generator (`tool/generate_sample_frame.dart`)
/// and `photoDumpFrame`, same as `sample_frame_layout.dart`.
const double photoDumpWidth = 1080;
const double photoDumpHeight = 1350;

/// Polaroid card padding around each photo — the thick bottom lip is the
/// classic instant-film look.
const double photoDumpCardPadSide = 22;
const double photoDumpCardPadBottom = 80;

const double _slotSize = 420;
const double _colX = 78;
const double _colGap = 504; // card width (464) + gap (40)
const double _rowY = 172;
const double _rowGap = 558; // card height (522) + gap (36)

const List<Rect> photoDumpSlotRects = [
  Rect.fromLTWH(_colX, _rowY, _slotSize, _slotSize),
  Rect.fromLTWH(_colX + _colGap, _rowY, _slotSize, _slotSize),
  Rect.fromLTWH(_colX, _rowY + _rowGap, _slotSize, _slotSize),
  Rect.fromLTWH(_colX + _colGap, _rowY + _rowGap, _slotSize, _slotSize),
];

/// The polaroid card drawn around a slot.
Rect photoDumpCardFor(Rect slot) => Rect.fromLTRB(
  slot.left - photoDumpCardPadSide,
  slot.top - photoDumpCardPadSide,
  slot.right + photoDumpCardPadSide,
  slot.bottom + photoDumpCardPadBottom,
);

const double photoDumpBorderWidth = 8;
const double photoDumpShadowOffset = 12;
