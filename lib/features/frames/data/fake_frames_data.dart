import 'package:snapframe/features/frames/data/sample_frame.dart';
import 'package:snapframe/features/frames/domain/frame.dart';
import 'package:snapframe/features/frames/domain/frame_status.dart';
import 'package:snapframe/features/frames/domain/frame_visibility.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

/// Every fake frame reuses `sampleFrame`'s overlay/slots — there's no
/// second piece of art yet, just varied metadata so Browse has something
/// real to filter, sort, and lock. Swap in real per-frame overlays once
/// Storage (Milestone 3+) or the frame editor (Milestone 5) exist.
final List<Frame> fakeFrames = [
  _frame(
    id: 'official-1',
    title: 'birthday bash',
    isOfficial: true,
    tier: Tier.free,
    usageCount: 812,
    daysAgo: 2,
  ),
  _frame(
    id: 'official-2',
    title: 'prom night',
    isOfficial: true,
    tier: Tier.pro,
    usageCount: 2310,
    daysAgo: 10,
  ),
  _frame(
    id: 'official-3',
    title: 'game night',
    isOfficial: true,
    tier: Tier.free,
    usageCount: 145,
    daysAgo: 1,
  ),
  _frame(
    id: 'official-4',
    title: 'vip only',
    isOfficial: true,
    tier: Tier.pro,
    usageCount: 990,
    daysAgo: 20,
  ),
  _frame(
    id: 'community-1',
    title: 'bestie strip',
    isOfficial: false,
    ownerId: 'maya',
    tier: Tier.free,
    usageCount: 58,
    daysAgo: 3,
  ),
  _frame(
    id: 'community-2',
    title: 'main character energy',
    isOfficial: false,
    ownerId: 'jordan',
    tier: Tier.pro,
    usageCount: 401,
    daysAgo: 6,
  ),
  _frame(
    id: 'community-3',
    title: 'y2k core',
    isOfficial: false,
    ownerId: 'ren',
    tier: Tier.free,
    usageCount: 22,
    daysAgo: 0,
  ),
];

Frame _frame({
  required String id,
  required String title,
  required bool isOfficial,
  required Tier tier,
  required int usageCount,
  required int daysAgo,
  String ownerId = 'snapframe',
}) {
  final createdAt = DateTime.now().subtract(Duration(days: daysAgo));
  return sampleFrame.copyWith(
    id: id,
    title: title,
    ownerId: ownerId,
    isOfficial: isOfficial,
    visibility: FrameVisibility.public,
    tier: tier,
    status: FrameStatus.approved,
    usageCount: usageCount,
    reportCount: 0,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}
