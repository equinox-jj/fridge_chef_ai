// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {

 ProfileEntity? get profile; BlocStatus get loadStatus; int? get scanCount; BlocStatus get dietaryStatus; Failure? get dietaryFailure; BlocStatus get signOutStatus; Failure? get signOutFailure; BlocStatus get avatarStatus; Failure? get avatarFailure;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.scanCount, scanCount) || other.scanCount == scanCount)&&(identical(other.dietaryStatus, dietaryStatus) || other.dietaryStatus == dietaryStatus)&&(identical(other.dietaryFailure, dietaryFailure) || other.dietaryFailure == dietaryFailure)&&(identical(other.signOutStatus, signOutStatus) || other.signOutStatus == signOutStatus)&&(identical(other.signOutFailure, signOutFailure) || other.signOutFailure == signOutFailure)&&(identical(other.avatarStatus, avatarStatus) || other.avatarStatus == avatarStatus)&&(identical(other.avatarFailure, avatarFailure) || other.avatarFailure == avatarFailure));
}


@override
int get hashCode => Object.hash(runtimeType,profile,loadStatus,scanCount,dietaryStatus,dietaryFailure,signOutStatus,signOutFailure,avatarStatus,avatarFailure);

@override
String toString() {
  return 'ProfileState(profile: $profile, loadStatus: $loadStatus, scanCount: $scanCount, dietaryStatus: $dietaryStatus, dietaryFailure: $dietaryFailure, signOutStatus: $signOutStatus, signOutFailure: $signOutFailure, avatarStatus: $avatarStatus, avatarFailure: $avatarFailure)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 ProfileEntity? profile, BlocStatus loadStatus, int? scanCount, BlocStatus dietaryStatus, Failure? dietaryFailure, BlocStatus signOutStatus, Failure? signOutFailure, BlocStatus avatarStatus, Failure? avatarFailure
});


$ProfileEntityCopyWith<$Res>? get profile;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = freezed,Object? loadStatus = null,Object? scanCount = freezed,Object? dietaryStatus = null,Object? dietaryFailure = freezed,Object? signOutStatus = null,Object? signOutFailure = freezed,Object? avatarStatus = null,Object? avatarFailure = freezed,}) {
  return _then(_self.copyWith(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileEntity?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,scanCount: freezed == scanCount ? _self.scanCount : scanCount // ignore: cast_nullable_to_non_nullable
as int?,dietaryStatus: null == dietaryStatus ? _self.dietaryStatus : dietaryStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,dietaryFailure: freezed == dietaryFailure ? _self.dietaryFailure : dietaryFailure // ignore: cast_nullable_to_non_nullable
as Failure?,signOutStatus: null == signOutStatus ? _self.signOutStatus : signOutStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,signOutFailure: freezed == signOutFailure ? _self.signOutFailure : signOutFailure // ignore: cast_nullable_to_non_nullable
as Failure?,avatarStatus: null == avatarStatus ? _self.avatarStatus : avatarStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,avatarFailure: freezed == avatarFailure ? _self.avatarFailure : avatarFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileEntityCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileEntityCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileEntity? profile,  BlocStatus loadStatus,  int? scanCount,  BlocStatus dietaryStatus,  Failure? dietaryFailure,  BlocStatus signOutStatus,  Failure? signOutFailure,  BlocStatus avatarStatus,  Failure? avatarFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.profile,_that.loadStatus,_that.scanCount,_that.dietaryStatus,_that.dietaryFailure,_that.signOutStatus,_that.signOutFailure,_that.avatarStatus,_that.avatarFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileEntity? profile,  BlocStatus loadStatus,  int? scanCount,  BlocStatus dietaryStatus,  Failure? dietaryFailure,  BlocStatus signOutStatus,  Failure? signOutFailure,  BlocStatus avatarStatus,  Failure? avatarFailure)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.profile,_that.loadStatus,_that.scanCount,_that.dietaryStatus,_that.dietaryFailure,_that.signOutStatus,_that.signOutFailure,_that.avatarStatus,_that.avatarFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileEntity? profile,  BlocStatus loadStatus,  int? scanCount,  BlocStatus dietaryStatus,  Failure? dietaryFailure,  BlocStatus signOutStatus,  Failure? signOutFailure,  BlocStatus avatarStatus,  Failure? avatarFailure)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.profile,_that.loadStatus,_that.scanCount,_that.dietaryStatus,_that.dietaryFailure,_that.signOutStatus,_that.signOutFailure,_that.avatarStatus,_that.avatarFailure);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState extends ProfileState {
  const _ProfileState({this.profile, this.loadStatus = BlocStatus.initial, this.scanCount, this.dietaryStatus = BlocStatus.initial, this.dietaryFailure, this.signOutStatus = BlocStatus.initial, this.signOutFailure, this.avatarStatus = BlocStatus.initial, this.avatarFailure}): super._();
  

@override final  ProfileEntity? profile;
@override@JsonKey() final  BlocStatus loadStatus;
@override final  int? scanCount;
@override@JsonKey() final  BlocStatus dietaryStatus;
@override final  Failure? dietaryFailure;
@override@JsonKey() final  BlocStatus signOutStatus;
@override final  Failure? signOutFailure;
@override@JsonKey() final  BlocStatus avatarStatus;
@override final  Failure? avatarFailure;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.scanCount, scanCount) || other.scanCount == scanCount)&&(identical(other.dietaryStatus, dietaryStatus) || other.dietaryStatus == dietaryStatus)&&(identical(other.dietaryFailure, dietaryFailure) || other.dietaryFailure == dietaryFailure)&&(identical(other.signOutStatus, signOutStatus) || other.signOutStatus == signOutStatus)&&(identical(other.signOutFailure, signOutFailure) || other.signOutFailure == signOutFailure)&&(identical(other.avatarStatus, avatarStatus) || other.avatarStatus == avatarStatus)&&(identical(other.avatarFailure, avatarFailure) || other.avatarFailure == avatarFailure));
}


@override
int get hashCode => Object.hash(runtimeType,profile,loadStatus,scanCount,dietaryStatus,dietaryFailure,signOutStatus,signOutFailure,avatarStatus,avatarFailure);

@override
String toString() {
  return 'ProfileState(profile: $profile, loadStatus: $loadStatus, scanCount: $scanCount, dietaryStatus: $dietaryStatus, dietaryFailure: $dietaryFailure, signOutStatus: $signOutStatus, signOutFailure: $signOutFailure, avatarStatus: $avatarStatus, avatarFailure: $avatarFailure)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileEntity? profile, BlocStatus loadStatus, int? scanCount, BlocStatus dietaryStatus, Failure? dietaryFailure, BlocStatus signOutStatus, Failure? signOutFailure, BlocStatus avatarStatus, Failure? avatarFailure
});


@override $ProfileEntityCopyWith<$Res>? get profile;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = freezed,Object? loadStatus = null,Object? scanCount = freezed,Object? dietaryStatus = null,Object? dietaryFailure = freezed,Object? signOutStatus = null,Object? signOutFailure = freezed,Object? avatarStatus = null,Object? avatarFailure = freezed,}) {
  return _then(_ProfileState(
profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileEntity?,loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,scanCount: freezed == scanCount ? _self.scanCount : scanCount // ignore: cast_nullable_to_non_nullable
as int?,dietaryStatus: null == dietaryStatus ? _self.dietaryStatus : dietaryStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,dietaryFailure: freezed == dietaryFailure ? _self.dietaryFailure : dietaryFailure // ignore: cast_nullable_to_non_nullable
as Failure?,signOutStatus: null == signOutStatus ? _self.signOutStatus : signOutStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,signOutFailure: freezed == signOutFailure ? _self.signOutFailure : signOutFailure // ignore: cast_nullable_to_non_nullable
as Failure?,avatarStatus: null == avatarStatus ? _self.avatarStatus : avatarStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,avatarFailure: freezed == avatarFailure ? _self.avatarFailure : avatarFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileEntityCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileEntityCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
