import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapframe/features/frames/domain/frame_status.dart';
import 'package:snapframe/features/frames/domain/frame_visibility.dart';
import 'package:snapframe/features/frames/domain/slot.dart';
import 'package:snapframe/features/frames/domain/tier.dart';

part 'frame.freezed.dart';
part 'frame.g.dart';

@freezed
abstract class Frame with _$Frame {
  const factory Frame({
    required String id,
    required String title,
    required String ownerId,
    required bool isOfficial,
    required FrameVisibility visibility,
    required Tier tier,
    required String overlayPath,
    required String thumbnailPath,
    required int width,
    required int height,
    required List<Slot> slots,
    required int countdownSec,
    required FrameStatus status,
    required int usageCount,
    required int reportCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Frame;

  factory Frame.fromJson(Map<String, dynamic> json) => _$FrameFromJson(json);
}
