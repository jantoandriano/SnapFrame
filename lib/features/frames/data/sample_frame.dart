import 'package:snapframe/features/frames/data/sample_frame_layout.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/frame_status.dart';
import 'package:snapframe/features/frames/domain/frame_visibility.dart';
import 'package:snapframe/features/frames/domain/slot.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

/// A bundled, always-available frame so the capture → composite → share
/// loop works fully offline, with no backend. Every field that would
/// normally come from Firestore (owner, status, counters, timestamps) is a
/// placeholder — this frame is never read from or written to Firestore.
final Frame sampleFrame = Frame(
  id: 'sample',
  title: 'classic strip',
  ownerId: 'snapframe',
  isOfficial: true,
  visibility: FrameVisibility.public,
  tier: Tier.free,
  overlayPath: 'assets/frames/sample_overlay.png',
  thumbnailPath: 'assets/frames/sample_overlay.png',
  width: sampleOverlayWidth.toInt(),
  height: sampleOverlayHeight.toInt(),
  slots: [
    for (final rect in sampleOverlaySlotRects)
      Slot(
        x: rect.left / sampleOverlayWidth,
        y: rect.top / sampleOverlayHeight,
        w: rect.width / sampleOverlayWidth,
        h: rect.height / sampleOverlayHeight,
      ),
  ],
  countdownSec: 3,
  status: FrameStatus.approved,
  usageCount: 0,
  reportCount: 0,
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
);
