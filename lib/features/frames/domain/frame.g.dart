// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Frame _$FrameFromJson(Map<String, dynamic> json) => _Frame(
  id: json['id'] as String,
  title: json['title'] as String,
  ownerId: json['ownerId'] as String,
  isOfficial: json['isOfficial'] as bool,
  visibility: $enumDecode(_$FrameVisibilityEnumMap, json['visibility']),
  tier: $enumDecode(_$TierEnumMap, json['tier']),
  overlayPath: json['overlayPath'] as String,
  thumbnailPath: json['thumbnailPath'] as String,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  slots: (json['slots'] as List<dynamic>)
      .map((e) => Slot.fromJson(e as Map<String, dynamic>))
      .toList(),
  countdownSec: (json['countdownSec'] as num).toInt(),
  status: $enumDecode(_$FrameStatusEnumMap, json['status']),
  usageCount: (json['usageCount'] as num).toInt(),
  reportCount: (json['reportCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$FrameToJson(_Frame instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'ownerId': instance.ownerId,
  'isOfficial': instance.isOfficial,
  'visibility': _$FrameVisibilityEnumMap[instance.visibility]!,
  'tier': _$TierEnumMap[instance.tier]!,
  'overlayPath': instance.overlayPath,
  'thumbnailPath': instance.thumbnailPath,
  'width': instance.width,
  'height': instance.height,
  'slots': instance.slots,
  'countdownSec': instance.countdownSec,
  'status': _$FrameStatusEnumMap[instance.status]!,
  'usageCount': instance.usageCount,
  'reportCount': instance.reportCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$FrameVisibilityEnumMap = {
  FrameVisibility.private: 'private',
  FrameVisibility.public: 'public',
};

const _$TierEnumMap = {Tier.free: 'free', Tier.pro: 'pro'};

const _$FrameStatusEnumMap = {
  FrameStatus.pending: 'pending',
  FrameStatus.approved: 'approved',
  FrameStatus.rejected: 'rejected',
};
