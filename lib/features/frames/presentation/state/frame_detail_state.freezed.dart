// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FrameDetailState {

 Frame get frame;/// Countdown picked by the user; overrides the frame's default when
/// capture starts.
 int get countdownSec; bool get isSubmittingReport; AppException? get error; FrameDetailEffect? get effect;
/// Create a copy of FrameDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrameDetailStateCopyWith<FrameDetailState> get copyWith => _$FrameDetailStateCopyWithImpl<FrameDetailState>(this as FrameDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FrameDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrameDetailState&&(identical(other.frame, _this.frame) || other.frame == _this.frame)&&(identical(other.countdownSec, _this.countdownSec) || other.countdownSec == _this.countdownSec)&&(identical(other.isSubmittingReport, _this.isSubmittingReport) || other.isSubmittingReport == _this.isSubmittingReport)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.effect, _this.effect) || other.effect == _this.effect));
}


@override
int get hashCode {
  final _this = this as FrameDetailState;
  return Object.hash(runtimeType,_this.frame,_this.countdownSec,_this.isSubmittingReport,_this.error,_this.effect);
}

@override
String toString() {
  final _this = this as FrameDetailState;
  return 'FrameDetailState(frame: ${_this.frame}, countdownSec: ${_this.countdownSec}, isSubmittingReport: ${_this.isSubmittingReport}, error: ${_this.error}, effect: ${_this.effect})';
}


}

/// @nodoc
abstract mixin class $FrameDetailStateCopyWith<$Res>  {
  factory $FrameDetailStateCopyWith(FrameDetailState value, $Res Function(FrameDetailState) _then) = _$FrameDetailStateCopyWithImpl;
@useResult
$Res call({
 Frame frame, int countdownSec, bool isSubmittingReport, AppException? error, FrameDetailEffect? effect
});


$FrameCopyWith<$Res> get frame;

}
/// @nodoc
class _$FrameDetailStateCopyWithImpl<$Res>
    implements $FrameDetailStateCopyWith<$Res> {
  _$FrameDetailStateCopyWithImpl(this._self, this._then);

  final FrameDetailState _self;
  final $Res Function(FrameDetailState) _then;

/// Create a copy of FrameDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? frame = null,Object? countdownSec = null,Object? isSubmittingReport = null,Object? error = freezed,Object? effect = freezed,}) {
  return _then(FrameDetailState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,countdownSec: null == countdownSec ? _self.countdownSec : countdownSec // ignore: cast_nullable_to_non_nullable
as int,isSubmittingReport: null == isSubmittingReport ? _self.isSubmittingReport : isSubmittingReport // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as FrameDetailEffect?,
  ));
}
/// Create a copy of FrameDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FrameCopyWith<$Res> get frame {
  
  return $FrameCopyWith<$Res>(_self.frame, (value) {
    return _then(_self.copyWith(frame: value));
  });
}
}


/// Adds pattern-matching-related methods to [FrameDetailState].
extension FrameDetailStatePatterns on FrameDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FrameDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FrameDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FrameDetailState value)  $default,){
final _that = this;
switch (_that) {
case _FrameDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FrameDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _FrameDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Frame frame,  int countdownSec,  bool isSubmittingReport,  AppException? error,  FrameDetailEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FrameDetailState() when $default != null:
return $default(_that.frame,_that.countdownSec,_that.isSubmittingReport,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Frame frame,  int countdownSec,  bool isSubmittingReport,  AppException? error,  FrameDetailEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _FrameDetailState():
return $default(_that.frame,_that.countdownSec,_that.isSubmittingReport,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Frame frame,  int countdownSec,  bool isSubmittingReport,  AppException? error,  FrameDetailEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _FrameDetailState() when $default != null:
return $default(_that.frame,_that.countdownSec,_that.isSubmittingReport,_that.error,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _FrameDetailState implements FrameDetailState {
  const _FrameDetailState({required this.frame, required this.countdownSec, this.isSubmittingReport = false, this.error, this.effect});
  

@override final  Frame frame;
/// Countdown picked by the user; overrides the frame's default when
/// capture starts.
@override final  int countdownSec;
@override@JsonKey() final  bool isSubmittingReport;
@override final  AppException? error;
@override final  FrameDetailEffect? effect;

/// Create a copy of FrameDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrameDetailStateCopyWith<_FrameDetailState> get copyWith => __$FrameDetailStateCopyWithImpl<_FrameDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrameDetailState&&(identical(other.frame, frame) || other.frame == frame)&&(identical(other.countdownSec, countdownSec) || other.countdownSec == countdownSec)&&(identical(other.isSubmittingReport, isSubmittingReport) || other.isSubmittingReport == isSubmittingReport)&&(identical(other.error, error) || other.error == error)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode {
    return Object.hash(runtimeType,frame,countdownSec,isSubmittingReport,error,effect);
}

@override
String toString() {
    return 'FrameDetailState(frame: $frame, countdownSec: $countdownSec, isSubmittingReport: $isSubmittingReport, error: $error, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$FrameDetailStateCopyWith<$Res> implements $FrameDetailStateCopyWith<$Res> {
  factory _$FrameDetailStateCopyWith(_FrameDetailState value, $Res Function(_FrameDetailState) _then) = __$FrameDetailStateCopyWithImpl;
@override @useResult
$Res call({
 Frame frame, int countdownSec, bool isSubmittingReport, AppException? error, FrameDetailEffect? effect
});


@override $FrameCopyWith<$Res> get frame;

}
/// @nodoc
class __$FrameDetailStateCopyWithImpl<$Res>
    implements _$FrameDetailStateCopyWith<$Res> {
  __$FrameDetailStateCopyWithImpl(this._self, this._then);

  final _FrameDetailState _self;
  final $Res Function(_FrameDetailState) _then;

/// Create a copy of FrameDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? frame = null,Object? countdownSec = null,Object? isSubmittingReport = null,Object? error = freezed,Object? effect = freezed,}) {
  return _then(_FrameDetailState(
frame: null == frame ? _self.frame : frame // ignore: cast_nullable_to_non_nullable
as Frame,countdownSec: null == countdownSec ? _self.countdownSec : countdownSec // ignore: cast_nullable_to_non_nullable
as int,isSubmittingReport: null == isSubmittingReport ? _self.isSubmittingReport : isSubmittingReport // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as FrameDetailEffect?,
  ));
}

/// Create a copy of FrameDetailState
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
