// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewState {

 Frame get frame; List<XFile> get captures; Uint8List? get previewJpeg; bool get isComposing;/// The slot most recently replaced by a retake, highlighted in the
/// strip so it's clear which shot changed.
 int? get updatedSlotIndex; AppException? get error; ReviewEffect? get effect;
/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewStateCopyWith<ReviewState> get copyWith => _$ReviewStateCopyWithImpl<ReviewState>(this as ReviewState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReviewState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewState&&(identical(other.frame, _this.frame) || other.frame == _this.frame)&&const DeepCollectionEquality().equals(other.captures, _this.captures)&&const DeepCollectionEquality().equals(other.previewJpeg, _this.previewJpeg)&&(identical(other.isComposing, _this.isComposing) || other.isComposing == _this.isComposing)&&(identical(other.updatedSlotIndex, _this.updatedSlotIndex) || other.updatedSlotIndex == _this.updatedSlotIndex)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.effect, _this.effect) || other.effect == _this.effect));
}


@override
int get hashCode {
  final _this = this as ReviewState;
  return Object.hash(runtimeType,_this.frame,const DeepCollectionEquality().hash(_this.captures),const DeepCollectionEquality().hash(_this.previewJpeg),_this.isComposing,_this.updatedSlotIndex,_this.error,_this.effect);
}

@override
String toString() {
  final _this = this as ReviewState;
  return 'ReviewState(frame: ${_this.frame}, captures: ${_this.captures}, previewJpeg: ${_this.previewJpeg}, isComposing: ${_this.isComposing}, updatedSlotIndex: ${_this.updatedSlotIndex}, error: ${_this.error}, effect: ${_this.effect})';
}


}

/// @nodoc
abstract mixin class $ReviewStateCopyWith<$Res>  {
  factory $ReviewStateCopyWith(ReviewState value, $Res Function(ReviewState) _then) = _$ReviewStateCopyWithImpl;
@useResult
$Res call({
 Frame frame, List<XFile> captures, Uint8List? previewJpeg, bool isComposing, int? updatedSlotIndex, AppException? error, ReviewEffect? effect
});


$FrameCopyWith<$Res> get frame;

}
/// @nodoc
class _$ReviewStateCopyWithImpl<$Res>
    implements $ReviewStateCopyWith<$Res> {
  _$ReviewStateCopyWithImpl(this._self, this._then);

  final ReviewState _self;
  final $Res Function(ReviewState) _then;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? frame = null,Object? captures = null,Object? previewJpeg = freezed,Object? isComposing = null,Object? updatedSlotIndex = freezed,Object? error = freezed,Object? effect = freezed,}) {
  return _then(ReviewState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,captures: null == captures ? _self.captures : captures // ignore: cast_nullable_to_non_nullable
as List<XFile>,previewJpeg: freezed == previewJpeg ? _self.previewJpeg : previewJpeg // ignore: cast_nullable_to_non_nullable
as Uint8List?,isComposing: null == isComposing ? _self.isComposing : isComposing // ignore: cast_nullable_to_non_nullable
as bool,updatedSlotIndex: freezed == updatedSlotIndex ? _self.updatedSlotIndex : updatedSlotIndex // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as ReviewEffect?,
  ));
}
/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrameCopyWith<$Res> get frame {
  
  return $FrameCopyWith<$Res>(_self.frame, (value) {
    return _then(_self.copyWith(frame: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReviewState].
extension ReviewStatePatterns on ReviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewState value)  $default,){
final _that = this;
switch (_that) {
case _ReviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewState value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Frame frame,  List<XFile> captures,  Uint8List? previewJpeg,  bool isComposing,  int? updatedSlotIndex,  AppException? error,  ReviewEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
return $default(_that.frame,_that.captures,_that.previewJpeg,_that.isComposing,_that.updatedSlotIndex,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Frame frame,  List<XFile> captures,  Uint8List? previewJpeg,  bool isComposing,  int? updatedSlotIndex,  AppException? error,  ReviewEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _ReviewState():
return $default(_that.frame,_that.captures,_that.previewJpeg,_that.isComposing,_that.updatedSlotIndex,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Frame frame,  List<XFile> captures,  Uint8List? previewJpeg,  bool isComposing,  int? updatedSlotIndex,  AppException? error,  ReviewEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _ReviewState() when $default != null:
return $default(_that.frame,_that.captures,_that.previewJpeg,_that.isComposing,_that.updatedSlotIndex,_that.error,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _ReviewState implements ReviewState {
  const _ReviewState({required this.frame, required  List<XFile> captures, this.previewJpeg, this.isComposing = false, this.updatedSlotIndex, this.error, this.effect}): _captures = captures;
  

@override final  Frame frame;
 final  List<XFile> _captures;
@override List<XFile> get captures {
  if (_captures is EqualUnmodifiableListView) return _captures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_captures);
}

@override final  Uint8List? previewJpeg;
@override@JsonKey() final  bool isComposing;
/// The slot most recently replaced by a retake, highlighted in the
/// strip so it's clear which shot changed.
@override final  int? updatedSlotIndex;
@override final  AppException? error;
@override final  ReviewEffect? effect;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewStateCopyWith<_ReviewState> get copyWith => __$ReviewStateCopyWithImpl<_ReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewState&&(identical(other.frame, frame) || other.frame == frame)&&const DeepCollectionEquality().equals(other.captures, _captures)&&const DeepCollectionEquality().equals(other.previewJpeg, previewJpeg)&&(identical(other.isComposing, isComposing) || other.isComposing == isComposing)&&(identical(other.updatedSlotIndex, updatedSlotIndex) || other.updatedSlotIndex == updatedSlotIndex)&&(identical(other.error, error) || other.error == error)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode {
    return Object.hash(runtimeType,frame,const DeepCollectionEquality().hash(_captures),const DeepCollectionEquality().hash(previewJpeg),isComposing,updatedSlotIndex,error,effect);
}

@override
String toString() {
    return 'ReviewState(frame: $frame, captures: $captures, previewJpeg: $previewJpeg, isComposing: $isComposing, updatedSlotIndex: $updatedSlotIndex, error: $error, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$ReviewStateCopyWith<$Res> implements $ReviewStateCopyWith<$Res> {
  factory _$ReviewStateCopyWith(_ReviewState value, $Res Function(_ReviewState) _then) = __$ReviewStateCopyWithImpl;
@override @useResult
$Res call({
 Frame frame, List<XFile> captures, Uint8List? previewJpeg, bool isComposing, int? updatedSlotIndex, AppException? error, ReviewEffect? effect
});


@override $FrameCopyWith<$Res> get frame;

}
/// @nodoc
class __$ReviewStateCopyWithImpl<$Res>
    implements _$ReviewStateCopyWith<$Res> {
  __$ReviewStateCopyWithImpl(this._self, this._then);

  final _ReviewState _self;
  final $Res Function(_ReviewState) _then;

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? frame = null,Object? captures = null,Object? previewJpeg = freezed,Object? isComposing = null,Object? updatedSlotIndex = freezed,Object? error = freezed,Object? effect = freezed,}) {
  return _then(_ReviewState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,captures: null == captures ? _self._captures : captures // ignore: cast_nullable_to_non_nullable
as List<XFile>,previewJpeg: freezed == previewJpeg ? _self.previewJpeg : previewJpeg // ignore: cast_nullable_to_non_nullable
as Uint8List?,isComposing: null == isComposing ? _self.isComposing : isComposing // ignore: cast_nullable_to_non_nullable
as bool,updatedSlotIndex: freezed == updatedSlotIndex ? _self.updatedSlotIndex : updatedSlotIndex // ignore: cast_nullable_to_non_nullable
as int?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as ReviewEffect?,
  ));
}

/// Create a copy of ReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrameCopyWith<$Res> get frame {
  
  return $FrameCopyWith<$Res>(_self.frame, (value) {
    return _then(_self.copyWith(frame: value));
  });
}
}

// dart format on
