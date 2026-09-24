// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browse_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrowseState {

 Tier get currentUserTier; int get tabIndex; BrowseFilter get selectedFilter; List<Frame> get frames; bool get isLoading; bool get isRefreshing; AppException? get error; BrowseEffect? get effect;
/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrowseStateCopyWith<BrowseState> get copyWith => _$BrowseStateCopyWithImpl<BrowseState>(this as BrowseState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BrowseState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrowseState&&(identical(other.currentUserTier, _this.currentUserTier) || other.currentUserTier == _this.currentUserTier)&&(identical(other.tabIndex, _this.tabIndex) || other.tabIndex == _this.tabIndex)&&(identical(other.selectedFilter, _this.selectedFilter) || other.selectedFilter == _this.selectedFilter)&&const DeepCollectionEquality().equals(other.frames, _this.frames)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.isRefreshing, _this.isRefreshing) || other.isRefreshing == _this.isRefreshing)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.effect, _this.effect) || other.effect == _this.effect));
}


@override
int get hashCode {
  final _this = this as BrowseState;
  return Object.hash(runtimeType,_this.currentUserTier,_this.tabIndex,_this.selectedFilter,const DeepCollectionEquality().hash(_this.frames),_this.isLoading,_this.isRefreshing,_this.error,_this.effect);
}

@override
String toString() {
  final _this = this as BrowseState;
  return 'BrowseState(currentUserTier: ${_this.currentUserTier}, tabIndex: ${_this.tabIndex}, selectedFilter: ${_this.selectedFilter}, frames: ${_this.frames}, isLoading: ${_this.isLoading}, isRefreshing: ${_this.isRefreshing}, error: ${_this.error}, effect: ${_this.effect})';
}


}

/// @nodoc
abstract mixin class $BrowseStateCopyWith<$Res>  {
  factory $BrowseStateCopyWith(BrowseState value, $Res Function(BrowseState) _then) = _$BrowseStateCopyWithImpl;
@useResult
$Res call({
 Tier currentUserTier, int tabIndex, BrowseFilter selectedFilter, List<Frame> frames, bool isLoading, bool isRefreshing, AppException? error, BrowseEffect? effect
});




}
/// @nodoc
class _$BrowseStateCopyWithImpl<$Res>
    implements $BrowseStateCopyWith<$Res> {
  _$BrowseStateCopyWithImpl(this._self, this._then);

  final BrowseState _self;
  final $Res Function(BrowseState) _then;

/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentUserTier = null,Object? tabIndex = null,Object? selectedFilter = null,Object? frames = null,Object? isLoading = null,Object? isRefreshing = null,Object? error = freezed,Object? effect = freezed,}) {
  return _then(BrowseState(
currentUserTier: null == currentUserTier ? _self.currentUserTier : currentUserTier // ignore: cast_nullable_to_non_nullable
as Tier,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,selectedFilter: null == selectedFilter ? _self.selectedFilter : selectedFilter // ignore: cast_nullable_to_non_nullable
as BrowseFilter,frames: null == frames ? _self.frames : frames // ignore: cast_nullable_to_non_nullable
as List<Frame>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as BrowseEffect?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrowseState].
extension BrowseStatePatterns on BrowseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrowseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrowseState value)  $default,){
final _that = this;
switch (_that) {
case _BrowseState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrowseState value)?  $default,){
final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Tier currentUserTier,  int tabIndex,  BrowseFilter selectedFilter,  List<Frame> frames,  bool isLoading,  bool isRefreshing,  AppException? error,  BrowseEffect? effect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
return $default(_that.currentUserTier,_that.tabIndex,_that.selectedFilter,_that.frames,_that.isLoading,_that.isRefreshing,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Tier currentUserTier,  int tabIndex,  BrowseFilter selectedFilter,  List<Frame> frames,  bool isLoading,  bool isRefreshing,  AppException? error,  BrowseEffect? effect)  $default,) {final _that = this;
switch (_that) {
case _BrowseState():
return $default(_that.currentUserTier,_that.tabIndex,_that.selectedFilter,_that.frames,_that.isLoading,_that.isRefreshing,_that.error,_that.effect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Tier currentUserTier,  int tabIndex,  BrowseFilter selectedFilter,  List<Frame> frames,  bool isLoading,  bool isRefreshing,  AppException? error,  BrowseEffect? effect)?  $default,) {final _that = this;
switch (_that) {
case _BrowseState() when $default != null:
return $default(_that.currentUserTier,_that.tabIndex,_that.selectedFilter,_that.frames,_that.isLoading,_that.isRefreshing,_that.error,_that.effect);case _:
  return null;

}
}

}

/// @nodoc


class _BrowseState implements BrowseState {
  const _BrowseState({required this.currentUserTier, this.tabIndex = 0, this.selectedFilter = BrowseFilter.newest,  List<Frame> frames = const <Frame>[], this.isLoading = true, this.isRefreshing = false, this.error, this.effect}): _frames = frames;
  

@override final  Tier currentUserTier;
@override@JsonKey() final  int tabIndex;
@override@JsonKey() final  BrowseFilter selectedFilter;
 final  List<Frame> _frames;
@override@JsonKey() List<Frame> get frames {
  if (_frames is EqualUnmodifiableListView) return _frames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_frames);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
@override final  AppException? error;
@override final  BrowseEffect? effect;

/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrowseStateCopyWith<_BrowseState> get copyWith => __$BrowseStateCopyWithImpl<_BrowseState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrowseState&&(identical(other.currentUserTier, currentUserTier) || other.currentUserTier == currentUserTier)&&(identical(other.tabIndex, tabIndex) || other.tabIndex == tabIndex)&&(identical(other.selectedFilter, selectedFilter) || other.selectedFilter == selectedFilter)&&const DeepCollectionEquality().equals(other.frames, _frames)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.error, error) || other.error == error)&&(identical(other.effect, effect) || other.effect == effect));
}


@override
int get hashCode {
    return Object.hash(runtimeType,currentUserTier,tabIndex,selectedFilter,const DeepCollectionEquality().hash(_frames),isLoading,isRefreshing,error,effect);
}

@override
String toString() {
    return 'BrowseState(currentUserTier: $currentUserTier, tabIndex: $tabIndex, selectedFilter: $selectedFilter, frames: $frames, isLoading: $isLoading, isRefreshing: $isRefreshing, error: $error, effect: $effect)';
}


}

/// @nodoc
abstract mixin class _$BrowseStateCopyWith<$Res> implements $BrowseStateCopyWith<$Res> {
  factory _$BrowseStateCopyWith(_BrowseState value, $Res Function(_BrowseState) _then) = __$BrowseStateCopyWithImpl;
@override @useResult
$Res call({
 Tier currentUserTier, int tabIndex, BrowseFilter selectedFilter, List<Frame> frames, bool isLoading, bool isRefreshing, AppException? error, BrowseEffect? effect
});




}
/// @nodoc
class __$BrowseStateCopyWithImpl<$Res>
    implements _$BrowseStateCopyWith<$Res> {
  __$BrowseStateCopyWithImpl(this._self, this._then);

  final _BrowseState _self;
  final $Res Function(_BrowseState) _then;

/// Create a copy of BrowseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentUserTier = null,Object? tabIndex = null,Object? selectedFilter = null,Object? frames = null,Object? isLoading = null,Object? isRefreshing = null,Object? error = freezed,Object? effect = freezed,}) {
  return _then(_BrowseState(
currentUserTier: null == currentUserTier ? _self.currentUserTier : currentUserTier // ignore: cast_nullable_to_non_nullable
as Tier,tabIndex: null == tabIndex ? _self.tabIndex : tabIndex // ignore: cast_nullable_to_non_nullable
as int,selectedFilter: null == selectedFilter ? _self.selectedFilter : selectedFilter // ignore: cast_nullable_to_non_nullable
as BrowseFilter,frames: null == frames ? _self._frames : frames // ignore: cast_nullable_to_non_nullable
as List<Frame>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppException?,effect: freezed == effect ? _self.effect : effect // ignore: cast_nullable_to_non_nullable
as BrowseEffect?,
  ));
}


}

// dart format on
