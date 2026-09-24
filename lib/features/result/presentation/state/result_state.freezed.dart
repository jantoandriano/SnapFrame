// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResultState {

 Frame get frame; Uint8List get jpegBytes; bool get isSaving; bool get isSharing; ResultEffect? get effect;
/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultStateCopyWith<ResultState> get copyWith => _$ResultStateCopyWithImpl<ResultState>(this as ResultState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResultState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResultState&&(identical(other.frame, _this.frame) || other.frame == _this.frame)&&const DeepCollectionEquality().equals(other.jpegBytes, _this.jpegBytes)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSharing, _this.isSharing) || other.isSharing == _this.isSharing)&&(identical(other.effect, _this.effect) || other.effect == _this.effect));
}


@override
int get hashCode {
  final _this = this as ResultState;
  return Object.hash(runtimeType,_this.frame,const DeepCollectionEquality().hash(_this.jpegBytes),_this.isSaving,_this.isSharing,_this.effect);
}

@override
String toString() {
  final _this = this as ResultState;
  return 'ResultState(frame: ${_this.frame}, jpegBytes: ${_this.jpegBytes}, isSaving: ${_this.isSaving}, isSharing: ${_this.isSharing}, effect: ${_this.effect})';
}


}

/// @nodoc
abstract mixin class $ResultStateCopyWith<$Res>  {
  factory $ResultStateCopyWith(ResultState value, $Res Function(ResultState) _then) = _$ResultStateCopyWithImpl;
@useResult
$Res call({
 Frame frame, Uint8List jpegBytes, bool isSaving, bool isSharing, ResultEffect? effect
});


$FrameCopyWith<$Res> get frame;

}
/// @nodoc
class _$ResultStateCopyWithImpl<$Res>
    implements $ResultStateCopyWith<$Res> {
  _$ResultStateCopyWithImpl(this._self, this._then);

  final ResultState _self;
  final $Res Function(ResultState) _then;

/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? frame = null,Object? jpegBytes = null,Object? isSaving = null,Object? isSharing = null,Object? effect = freezed,}) {
  return _then(ResultState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,jpegBytes: null == jpegBytes ? _self.jpegBytes : jpegBytes // ignore: cast_nullable_to_non_nullable
as Uint8List,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSharing: null == isSharing ? _self.isSharing : isSharing // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as ResultEffect?,
  ));
}
/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrameCopyWith<$Res> get frame {
  
  return $FrameCopyWith<$Res>(_self.frame, (value) {
    return _then(_self.copyWith(frame: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResultState].
extension ResultStatePatterns on ResultState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResultState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResultState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResultState value)  $default,){
final _that = this;
switch (_that) {
case _ResultState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResultState value)?  $default,){
final _that = this;
switch (_that) {
case _ResultState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Frame frame,  Uint8List jpegBytes,  bool isSaving,  bool isSharing,  ResultEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResultState() when $default != null:
return $default(_that.frame,_that.jpegBytes,_that.isSaving,_that.isSharing,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Frame frame,  Uint8List jpegBytes,  bool isSaving,  bool isSharing,  ResultEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _ResultState():
return $default(_that.frame,_that.jpegBytes,_that.isSaving,_that.isSharing,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Frame frame,  Uint8List jpegBytes,  bool isSaving,  bool isSharing,  ResultEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _ResultState() when $default != null:
return $default(_that.frame,_that.jpegBytes,_that.isSaving,_that.isSharing,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _ResultState implements ResultState {
  const _ResultState({required this.frame, required this.jpegBytes, this.isSaving = false, this.isSharing = false, this.effect});
  

@override final  Frame frame;
@override final  Uint8List jpegBytes;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSharing;
@override final  ResultEffect? effect;

/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResultStateCopyWith<_ResultState> get copyWith => __$ResultStateCopyWithImpl<_ResultState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResultState&&(identical(other.frame, frame) || other.frame == frame)&&const DeepCollectionEquality().equals(other.jpegBytes, jpegBytes)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSharing, isSharing) || other.isSharing == isSharing)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode {
    return Object.hash(runtimeType,frame,const DeepCollectionEquality().hash(jpegBytes),isSaving,isSharing,effect);
}

@override
String toString() {
    return 'ResultState(frame: $frame, jpegBytes: $jpegBytes, isSaving: $isSaving, isSharing: $isSharing, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$ResultStateCopyWith<$Res> implements $ResultStateCopyWith<$Res> {
  factory _$ResultStateCopyWith(_ResultState value, $Res Function(_ResultState) _then) = __$ResultStateCopyWithImpl;
@override @useResult
$Res call({
 Frame frame, Uint8List jpegBytes, bool isSaving, bool isSharing, ResultEffect? effect
});


@override $FrameCopyWith<$Res> get frame;

}
/// @nodoc
class __$ResultStateCopyWithImpl<$Res>
    implements _$ResultStateCopyWith<$Res> {
  __$ResultStateCopyWithImpl(this._self, this._then);

  final _ResultState _self;
  final $Res Function(_ResultState) _then;

/// Create a copy of ResultState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? frame = null,Object? jpegBytes = null,Object? isSaving = null,Object? isSharing = null,Object? effect = freezed,}) {
  return _then(_ResultState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,jpegBytes: null == jpegBytes ? _self.jpegBytes : jpegBytes // ignore: cast_nullable_to_non_nullable
as Uint8List,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSharing: null == isSharing ? _self.isSharing : isSharing // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as ResultEffect?,
  ));
}

/// Create a copy of ResultState
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
