// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Frame {

 String get id; String get title; String get ownerId; bool get isOfficial; FrameVisibility get visibility; Tier get tier; String get overlayPath; String get thumbnailPath; int get width; int get height; List<Slot> get slots; int get countdownSec; FrameStatus get status; int get usageCount; int get reportCount; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Frame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrameCopyWith<Frame> get copyWith => _$FrameCopyWithImpl<Frame>(this as Frame, _$identity);

  /// Serializes this Frame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Frame;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Frame&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.ownerId, _this.ownerId) || other.ownerId == _this.ownerId)&&(identical(other.isOfficial, _this.isOfficial) || other.isOfficial == _this.isOfficial)&&(identical(other.visibility, _this.visibility) || other.visibility == _this.visibility)&&(identical(other.tier, _this.tier) || other.tier == _this.tier)&&(identical(other.overlayPath, _this.overlayPath) || other.overlayPath == _this.overlayPath)&&(identical(other.thumbnailPath, _this.thumbnailPath) || other.thumbnailPath == _this.thumbnailPath)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&const DeepCollectionEquality().equals(other.slots, _this.slots)&&(identical(other.countdownSec, _this.countdownSec) || other.countdownSec == _this.countdownSec)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.usageCount, _this.usageCount) || other.usageCount == _this.usageCount)&&(identical(other.reportCount, _this.reportCount) || other.reportCount == _this.reportCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Frame;
  return Object.hash(runtimeType,_this.id,_this.title,_this.ownerId,_this.isOfficial,_this.visibility,_this.tier,_this.overlayPath,_this.thumbnailPath,_this.width,_this.height,const DeepCollectionEquality().hash(_this.slots),_this.countdownSec,_this.status,_this.usageCount,_this.reportCount,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Frame;
  return 'Frame(id: ${_this.id}, title: ${_this.title}, ownerId: ${_this.ownerId}, isOfficial: ${_this.isOfficial}, visibility: ${_this.visibility}, tier: ${_this.tier}, overlayPath: ${_this.overlayPath}, thumbnailPath: ${_this.thumbnailPath}, width: ${_this.width}, height: ${_this.height}, slots: ${_this.slots}, countdownSec: ${_this.countdownSec}, status: ${_this.status}, usageCount: ${_this.usageCount}, reportCount: ${_this.reportCount}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $FrameCopyWith<$Res>  {
  factory $FrameCopyWith(Frame value, $Res Function(Frame) _then) = _$FrameCopyWithImpl;
@useResult
$Res call({
 String id, String title, String ownerId, bool isOfficial, FrameVisibility visibility, Tier tier, String overlayPath, String thumbnailPath, int width, int height, List<Slot> slots, int countdownSec, FrameStatus status, int usageCount, int reportCount, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$FrameCopyWithImpl<$Res>
    implements $FrameCopyWith<$Res> {
  _$FrameCopyWithImpl(this._self, this._then);

  final Frame _self;
  final $Res Function(Frame) _then;

/// Create a copy of Frame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? ownerId = null,Object? isOfficial = null,Object? visibility = null,Object? tier = null,Object? overlayPath = null,Object? thumbnailPath = null,Object? width = null,Object? height = null,Object? slots = null,Object? countdownSec = null,Object? status = null,Object? usageCount = null,Object? reportCount = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Frame(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,isOfficial: null == isOfficial ? _self.isOfficial : isOfficial // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as FrameVisibility,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as Tier,overlayPath: null == overlayPath ? _self.overlayPath : overlayPath // ignore: cast_nullable_to_non_nullable
as String,thumbnailPath: null == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<Slot>,countdownSec: null == countdownSec ? _self.countdownSec : countdownSec // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FrameStatus,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Frame].
extension FramePatterns on Frame {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Frame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Frame() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Frame value)  $default,){
final _that = this;
switch (_that) {
case _Frame():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Frame value)?  $default,){
final _that = this;
switch (_that) {
case _Frame() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String ownerId,  bool isOfficial,  FrameVisibility visibility,  Tier tier,  String overlayPath,  String thumbnailPath,  int width,  int height,  List<Slot> slots,  int countdownSec,  FrameStatus status,  int usageCount,  int reportCount,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Frame() when $default != null:
return $default(_that.id,_that.title,_that.ownerId,_that.isOfficial,_that.visibility,_that.tier,_that.overlayPath,_that.thumbnailPath,_that.width,_that.height,_that.slots,_that.countdownSec,_that.status,_that.usageCount,_that.reportCount,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String ownerId,  bool isOfficial,  FrameVisibility visibility,  Tier tier,  String overlayPath,  String thumbnailPath,  int width,  int height,  List<Slot> slots,  int countdownSec,  FrameStatus status,  int usageCount,  int reportCount,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Frame():
return $default(_that.id,_that.title,_that.ownerId,_that.isOfficial,_that.visibility,_that.tier,_that.overlayPath,_that.thumbnailPath,_that.width,_that.height,_that.slots,_that.countdownSec,_that.status,_that.usageCount,_that.reportCount,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String ownerId,  bool isOfficial,  FrameVisibility visibility,  Tier tier,  String overlayPath,  String thumbnailPath,  int width,  int height,  List<Slot> slots,  int countdownSec,  FrameStatus status,  int usageCount,  int reportCount,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Frame() when $default != null:
return $default(_that.id,_that.title,_that.ownerId,_that.isOfficial,_that.visibility,_that.tier,_that.overlayPath,_that.thumbnailPath,_that.width,_that.height,_that.slots,_that.countdownSec,_that.status,_that.usageCount,_that.reportCount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Frame implements Frame {
  const _Frame({required this.id, required this.title, required this.ownerId, required this.isOfficial, required this.visibility, required this.tier, required this.overlayPath, required this.thumbnailPath, required this.width, required this.height, required  List<Slot> slots, required this.countdownSec, required this.status, required this.usageCount, required this.reportCount, required this.createdAt, required this.updatedAt}): _slots = slots;
  factory _Frame.fromJson(Map<String, dynamic> json) => _$FrameFromJson(json);

@override final  String id;
@override final  String title;
@override final  String ownerId;
@override final  bool isOfficial;
@override final  FrameVisibility visibility;
@override final  Tier tier;
@override final  String overlayPath;
@override final  String thumbnailPath;
@override final  int width;
@override final  int height;
 final  List<Slot> _slots;
@override List<Slot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

@override final  int countdownSec;
@override final  FrameStatus status;
@override final  int usageCount;
@override final  int reportCount;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Frame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrameCopyWith<_Frame> get copyWith => __$FrameCopyWithImpl<_Frame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FrameToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Frame&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isOfficial, isOfficial) || other.isOfficial == isOfficial)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.overlayPath, overlayPath) || other.overlayPath == overlayPath)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&const DeepCollectionEquality().equals(other.slots, _slots)&&(identical(other.countdownSec, countdownSec) || other.countdownSec == countdownSec)&&(identical(other.status, status) || other.status == status)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.reportCount, reportCount) || other.reportCount == reportCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,ownerId,isOfficial,visibility,tier,overlayPath,thumbnailPath,width,height,const DeepCollectionEquality().hash(_slots),countdownSec,status,usageCount,reportCount,createdAt,updatedAt);
}

@override
String toString() {
    return 'Frame(id: $id, title: $title, ownerId: $ownerId, isOfficial: $isOfficial, visibility: $visibility, tier: $tier, overlayPath: $overlayPath, thumbnailPath: $thumbnailPath, width: $width, height: $height, slots: $slots, countdownSec: $countdownSec, status: $status, usageCount: $usageCount, reportCount: $reportCount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FrameCopyWith<$Res> implements $FrameCopyWith<$Res> {
  factory _$FrameCopyWith(_Frame value, $Res Function(_Frame) _then) = __$FrameCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String ownerId, bool isOfficial, FrameVisibility visibility, Tier tier, String overlayPath, String thumbnailPath, int width, int height, List<Slot> slots, int countdownSec, FrameStatus status, int usageCount, int reportCount, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$FrameCopyWithImpl<$Res>
    implements _$FrameCopyWith<$Res> {
  __$FrameCopyWithImpl(this._self, this._then);

  final _Frame _self;
  final $Res Function(_Frame) _then;

/// Create a copy of Frame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? ownerId = null,Object? isOfficial = null,Object? visibility = null,Object? tier = null,Object? overlayPath = null,Object? thumbnailPath = null,Object? width = null,Object? height = null,Object? slots = null,Object? countdownSec = null,Object? status = null,Object? usageCount = null,Object? reportCount = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Frame(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,isOfficial: null == isOfficial ? _self.isOfficial : isOfficial // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as FrameVisibility,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as Tier,overlayPath: null == overlayPath ? _self.overlayPath : overlayPath // ignore: cast_nullable_to_non_nullable
as String,thumbnailPath: null == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<Slot>,countdownSec: null == countdownSec ? _self.countdownSec : countdownSec // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FrameStatus,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,reportCount: null == reportCount ? _self.reportCount : reportCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
