// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CaptureState {

 Frame get frame; int get currentSlotIndex; List<XFile?> get captures; CapturePhase get phase; CameraLensDirection get cameraLens; AppException? get error; CaptureEffect? get effect;
/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptureStateCopyWith<CaptureState> get copyWith => _$CaptureStateCopyWithImpl<CaptureState>(this as CaptureState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CaptureState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureState&&(identical(other.frame, _this.frame) || other.frame == _this.frame)&&(identical(other.currentSlotIndex, _this.currentSlotIndex) || other.currentSlotIndex == _this.currentSlotIndex)&&const DeepCollectionEquality().equals(other.captures, _this.captures)&&(identical(other.phase, _this.phase) || other.phase == _this.phase)&&(identical(other.cameraLens, _this.cameraLens) || other.cameraLens == _this.cameraLens)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.effect, _this.effect) || other.effect == _this.effect));
}


@override
int get hashCode {
  final _this = this as CaptureState;
  return Object.hash(runtimeType,_this.frame,_this.currentSlotIndex,const DeepCollectionEquality().hash(_this.captures),_this.phase,_this.cameraLens,_this.error,_this.effect);
}

@override
String toString() {
  final _this = this as CaptureState;
  return 'CaptureState(frame: ${_this.frame}, currentSlotIndex: ${_this.currentSlotIndex}, captures: ${_this.captures}, phase: ${_this.phase}, cameraLens: ${_this.cameraLens}, error: ${_this.error}, effect: ${_this.effect})';
}


}

/// @nodoc
abstract mixin class $CaptureStateCopyWith<$Res>  {
  factory $CaptureStateCopyWith(CaptureState value, $Res Function(CaptureState) _then) = _$CaptureStateCopyWithImpl;
@useResult
$Res call({
 Frame frame, int currentSlotIndex, List<XFile?> captures, CapturePhase phase, CameraLensDirection cameraLens, AppException? error, CaptureEffect? effect
});


$FrameCopyWith<$Res> get frame;$CapturePhaseCopyWith<$Res> get phase;

}
/// @nodoc
class _$CaptureStateCopyWithImpl<$Res>
    implements $CaptureStateCopyWith<$Res> {
  _$CaptureStateCopyWithImpl(this._self, this._then);

  final CaptureState _self;
  final $Res Function(CaptureState) _then;

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? frame = null,Object? currentSlotIndex = null,Object? captures = null,Object? phase = null,Object? cameraLens = null,Object? error = freezed,Object? effect = freezed,}) {
  return _then(CaptureState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,currentSlotIndex: null == currentSlotIndex ? _self.currentSlotIndex : currentSlotIndex // ignore: cast_nullable_to_non_nullable
as int,captures: null == captures ? _self.captures : captures // ignore: cast_nullable_to_non_nullable
as List<XFile?>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CapturePhase,cameraLens: null == cameraLens ? _self.cameraLens : cameraLens // ignore: cast_nullable_to_non_nullable
as CameraLensDirection,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as CaptureEffect?,
  ));
}
/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrameCopyWith<$Res> get frame {
  
  return $FrameCopyWith<$Res>(_self.frame, (value) {
    return _then(_self.copyWith(frame: value));
  });
}/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapturePhaseCopyWith<$Res> get phase {
  
  return $CapturePhaseCopyWith<$Res>(_self.phase, (value) {
    return _then(_self.copyWith(phase: value));
  });
}
}


/// Adds pattern-matching-related methods to [CaptureState].
extension CaptureStatePatterns on CaptureState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptureState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptureState value)  $default,){
final _that = this;
switch (_that) {
case _CaptureState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptureState value)?  $default,){
final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Frame frame,  int currentSlotIndex,  List<XFile?> captures,  CapturePhase phase,  CameraLensDirection cameraLens,  AppException? error,  CaptureEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
return $default(_that.frame,_that.currentSlotIndex,_that.captures,_that.phase,_that.cameraLens,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Frame frame,  int currentSlotIndex,  List<XFile?> captures,  CapturePhase phase,  CameraLensDirection cameraLens,  AppException? error,  CaptureEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _CaptureState():
return $default(_that.frame,_that.currentSlotIndex,_that.captures,_that.phase,_that.cameraLens,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Frame frame,  int currentSlotIndex,  List<XFile?> captures,  CapturePhase phase,  CameraLensDirection cameraLens,  AppException? error,  CaptureEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _CaptureState() when $default != null:
return $default(_that.frame,_that.currentSlotIndex,_that.captures,_that.phase,_that.cameraLens,_that.error,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _CaptureState implements CaptureState {
  const _CaptureState({required this.frame, required this.currentSlotIndex, required  List<XFile?> captures, required this.phase, required this.cameraLens, this.error, this.effect}): _captures = captures;
  

@override final  Frame frame;
@override final  int currentSlotIndex;
 final  List<XFile?> _captures;
@override List<XFile?> get captures {
  if (_captures is EqualUnmodifiableListView) return _captures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_captures);
}

@override final  CapturePhase phase;
@override final  CameraLensDirection cameraLens;
@override final  AppException? error;
@override final  CaptureEffect? effect;

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptureStateCopyWith<_CaptureState> get copyWith => __$CaptureStateCopyWithImpl<_CaptureState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptureState&&(identical(other.frame, frame) || other.frame == frame)&&(identical(other.currentSlotIndex, currentSlotIndex) || other.currentSlotIndex == currentSlotIndex)&&const DeepCollectionEquality().equals(other.captures, _captures)&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.cameraLens, cameraLens) || other.cameraLens == cameraLens)&&(identical(other.error, error) || other.error == error)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode {
    return Object.hash(runtimeType,frame,currentSlotIndex,const DeepCollectionEquality().hash(_captures),phase,cameraLens,error,effect);
}

@override
String toString() {
    return 'CaptureState(frame: $frame, currentSlotIndex: $currentSlotIndex, captures: $captures, phase: $phase, cameraLens: $cameraLens, error: $error, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$CaptureStateCopyWith<$Res> implements $CaptureStateCopyWith<$Res> {
  factory _$CaptureStateCopyWith(_CaptureState value, $Res Function(_CaptureState) _then) = __$CaptureStateCopyWithImpl;
@override @useResult
$Res call({
 Frame frame, int currentSlotIndex, List<XFile?> captures, CapturePhase phase, CameraLensDirection cameraLens, AppException? error, CaptureEffect? effect
});


@override $FrameCopyWith<$Res> get frame;@override $CapturePhaseCopyWith<$Res> get phase;

}
/// @nodoc
class __$CaptureStateCopyWithImpl<$Res>
    implements _$CaptureStateCopyWith<$Res> {
  __$CaptureStateCopyWithImpl(this._self, this._then);

  final _CaptureState _self;
  final $Res Function(_CaptureState) _then;

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? frame = null,Object? currentSlotIndex = null,Object? captures = null,Object? phase = null,Object? cameraLens = null,Object? error = freezed,Object? effect = freezed,}) {
  return _then(_CaptureState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,currentSlotIndex: null == currentSlotIndex ? _self.currentSlotIndex : currentSlotIndex // ignore: cast_nullable_to_non_nullable
as int,captures: null == captures ? _self._captures : captures // ignore: cast_nullable_to_non_nullable
as List<XFile?>,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as CapturePhase,cameraLens: null == cameraLens ? _self.cameraLens : cameraLens // ignore: cast_nullable_to_non_nullable
as CameraLensDirection,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as CaptureEffect?,
  ));
}

/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrameCopyWith<$Res> get frame {
  
  return $FrameCopyWith<$Res>(_self.frame, (value) {
    return _then(_self.copyWith(frame: value));
  });
}/// Create a copy of CaptureState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapturePhaseCopyWith<$Res> get phase {
  
  return $CapturePhaseCopyWith<$Res>(_self.phase, (value) {
    return _then(_self.copyWith(phase: value));
  });
}
}

// dart format on
