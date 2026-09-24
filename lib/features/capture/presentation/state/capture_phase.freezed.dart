// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'capture_phase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CapturePhase {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CapturePhase);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CapturePhase()';
}


}

/// @nodoc
class $CapturePhaseCopyWith<$Res>  {
$CapturePhaseCopyWith(CapturePhase _, $Res Function(CapturePhase) __);
}


/// Adds pattern-matching-related methods to [CapturePhase].
extension CapturePhasePatterns on CapturePhase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CaptureIdle value)?  idle,TResult Function( CaptureCountingDown value)?  countingDown,TResult Function( CaptureCapturing value)?  capturing,TResult Function( CaptureDone value)?  done,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CaptureIdle() when idle != null:
return idle(_that);case CaptureCountingDown() when countingDown != null:
return countingDown(_that);case CaptureCapturing() when capturing != null:
return capturing(_that);case CaptureDone() when done != null:
return done(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CaptureIdle value)  idle,required TResult Function( CaptureCountingDown value)  countingDown,required TResult Function( CaptureCapturing value)  capturing,required TResult Function( CaptureDone value)  done,}){
final _that = this;
switch (_that) {
case CaptureIdle():
return idle(_that);case CaptureCountingDown():
return countingDown(_that);case CaptureCapturing():
return capturing(_that);case CaptureDone():
return done(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CaptureIdle value)?  idle,TResult? Function( CaptureCountingDown value)?  countingDown,TResult? Function( CaptureCapturing value)?  capturing,TResult? Function( CaptureDone value)?  done,}){
final _that = this;
switch (_that) {
case CaptureIdle() when idle != null:
return idle(_that);case CaptureCountingDown() when countingDown != null:
return countingDown(_that);case CaptureCapturing() when capturing != null:
return capturing(_that);case CaptureDone() when done != null:
return done(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( int n)?  countingDown,TResult Function()?  capturing,TResult Function()?  done,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CaptureIdle() when idle != null:
return idle();case CaptureCountingDown() when countingDown != null:
return countingDown(_that.n);case CaptureCapturing() when capturing != null:
return capturing();case CaptureDone() when done != null:
return done();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( int n)  countingDown,required TResult Function()  capturing,required TResult Function()  done,}) {final _that = this;
switch (_that) {
case CaptureIdle():
return idle();case CaptureCountingDown():
return countingDown(_that.n);case CaptureCapturing():
return capturing();case CaptureDone():
return done();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( int n)?  countingDown,TResult? Function()?  capturing,TResult? Function()?  done,}) {final _that = this;
switch (_that) {
case CaptureIdle() when idle != null:
return idle();case CaptureCountingDown() when countingDown != null:
return countingDown(_that.n);case CaptureCapturing() when capturing != null:
return capturing();case CaptureDone() when done != null:
return done();case _:
  return null;

}
}

}

/// @nodoc


class CaptureIdle implements CapturePhase {
  const CaptureIdle();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CapturePhase.idle()';
}


}




/// @nodoc


class CaptureCountingDown implements CapturePhase {
  const CaptureCountingDown(this.n);
  

 final  int n;

/// Create a copy of CapturePhase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptureCountingDownCopyWith<CaptureCountingDown> get copyWith => _$CaptureCountingDownCopyWithImpl<CaptureCountingDown>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureCountingDown&&(identical(other.n, n) || other.n == n));
}


@override
int get hashCode {
    return Object.hash(runtimeType,n);
}

@override
String toString() {
    return 'CapturePhase.countingDown(n: $n)';
}


}

/// @nodoc
abstract mixin class $CaptureCountingDownCopyWith<$Res> implements $CapturePhaseCopyWith<$Res> {
  factory $CaptureCountingDownCopyWith(CaptureCountingDown value, $Res Function(CaptureCountingDown) _then) = _$CaptureCountingDownCopyWithImpl;
@useResult
$Res call({
 int n
});




}
/// @nodoc
class _$CaptureCountingDownCopyWithImpl<$Res>
    implements $CaptureCountingDownCopyWith<$Res> {
  _$CaptureCountingDownCopyWithImpl(this._self, this._then);

  final CaptureCountingDown _self;
  final $Res Function(CaptureCountingDown) _then;

/// Create a copy of CapturePhase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? n = null,}) {
  return _then(CaptureCountingDown(
null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CaptureCapturing implements CapturePhase {
  const CaptureCapturing();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureCapturing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CapturePhase.capturing()';
}


}




/// @nodoc


class CaptureDone implements CapturePhase {
  const CaptureDone();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptureDone);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CapturePhase.done()';
}


}




// dart format on
