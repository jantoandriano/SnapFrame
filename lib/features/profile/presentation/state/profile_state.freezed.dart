// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {

 AppUser? get user;/// True only until the user stream first answers. Once it has, a null
/// [user] means signed out — not "still loading".
 bool get isLoadingUser; bool get isUpdatingPlan; ProfileEffect? get effect;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.isLoadingUser, _this.isLoadingUser) || other.isLoadingUser == _this.isLoadingUser)&&(identical(other.isUpdatingPlan, _this.isUpdatingPlan) || other.isUpdatingPlan == _this.isUpdatingPlan)&&(identical(other.effect, _this.effect) || other.effect == _this.effect));
}


@override
int get hashCode {
  final _this = this as ProfileState;
  return Object.hash(runtimeType,_this.user,_this.isLoadingUser,_this.isUpdatingPlan,_this.effect);
}

@override
String toString() {
  final _this = this as ProfileState;
  return 'ProfileState(user: ${_this.user}, isLoadingUser: ${_this.isLoadingUser}, isUpdatingPlan: ${_this.isUpdatingPlan}, effect: ${_this.effect})';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 AppUser? user, bool isLoadingUser, bool isUpdatingPlan, ProfileEffect? effect
});


$AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? isLoadingUser = null,Object? isUpdatingPlan = null,Object? effect = freezed,}) {
  return _then(ProfileState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,isLoadingUser: null == isLoadingUser ? _self.isLoadingUser : isLoadingUser // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingPlan: null == isUpdatingPlan ? _self.isUpdatingPlan : isUpdatingPlan // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as ProfileEffect?,
  ));
}
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppUser? user,  bool isLoadingUser,  bool isUpdatingPlan,  ProfileEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.user,_that.isLoadingUser,_that.isUpdatingPlan,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppUser? user,  bool isLoadingUser,  bool isUpdatingPlan,  ProfileEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.user,_that.isLoadingUser,_that.isUpdatingPlan,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppUser? user,  bool isLoadingUser,  bool isUpdatingPlan,  ProfileEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.user,_that.isLoadingUser,_that.isUpdatingPlan,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState implements ProfileState {
  const _ProfileState({this.user, this.isLoadingUser = true, this.isUpdatingPlan = false, this.effect});
  

@override final  AppUser? user;
/// True only until the user stream first answers. Once it has, a null
/// [user] means signed out — not "still loading".
@override@JsonKey() final  bool isLoadingUser;
@override@JsonKey() final  bool isUpdatingPlan;
@override final  ProfileEffect? effect;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.user, user) || other.user == user)&&(identical(other.isLoadingUser, isLoadingUser) || other.isLoadingUser == isLoadingUser)&&(identical(other.isUpdatingPlan, isUpdatingPlan) || other.isUpdatingPlan == isUpdatingPlan)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode {
    return Object.hash(runtimeType,user,isLoadingUser,isUpdatingPlan,effect);
}

@override
String toString() {
    return 'ProfileState(user: $user, isLoadingUser: $isLoadingUser, isUpdatingPlan: $isUpdatingPlan, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 AppUser? user, bool isLoadingUser, bool isUpdatingPlan, ProfileEffect? effect
});


@override $AppUserCopyWith<$Res>? get user;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? isLoadingUser = null,Object? isUpdatingPlan = null,Object? effect = freezed,}) {
  return _then(_ProfileState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AppUser?,isLoadingUser: null == isLoadingUser ? _self.isLoadingUser : isLoadingUser // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingPlan: null == isUpdatingPlan ? _self.isUpdatingPlan : isUpdatingPlan // ignore: cast_nullable_to_non_nullable
as bool,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as ProfileEffect?,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AppUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
