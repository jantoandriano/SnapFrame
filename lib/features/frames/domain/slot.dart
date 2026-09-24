import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot.freezed.dart';
part 'slot.g.dart';

/// A photo cutout rect within a frame overlay, normalized to 0..1 so it's
/// resolution-independent of the overlay's native pixel size.
@freezed
abstract class Slot with _$Slot {
  const factory Slot({
    required double x,
    required double y,
    required double w,
    required double h,
  }) = _Slot;

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
}
