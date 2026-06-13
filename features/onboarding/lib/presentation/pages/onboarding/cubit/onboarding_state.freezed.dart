// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingState {

/// The page currently in view, mirrored from the [PageView] so the dots and
/// the primary button stay in sync.
 int get pageIndex;/// The dietary preference chosen on the setup page (defaults to "no
/// restriction" until the user picks one).
 DietaryPreference get dietaryPreference;/// Tracks persisting the completion flag when the user finishes.
 BlocStatus get finishStatus; Failure? get finishFailure;
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateCopyWith<OnboardingState> get copyWith => _$OnboardingStateCopyWithImpl<OnboardingState>(this as OnboardingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.dietaryPreference, dietaryPreference) || other.dietaryPreference == dietaryPreference)&&(identical(other.finishStatus, finishStatus) || other.finishStatus == finishStatus)&&(identical(other.finishFailure, finishFailure) || other.finishFailure == finishFailure));
}


@override
int get hashCode => Object.hash(runtimeType,pageIndex,dietaryPreference,finishStatus,finishFailure);

@override
String toString() {
  return 'OnboardingState(pageIndex: $pageIndex, dietaryPreference: $dietaryPreference, finishStatus: $finishStatus, finishFailure: $finishFailure)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res>  {
  factory $OnboardingStateCopyWith(OnboardingState value, $Res Function(OnboardingState) _then) = _$OnboardingStateCopyWithImpl;
@useResult
$Res call({
 int pageIndex, DietaryPreference dietaryPreference, BlocStatus finishStatus, Failure? finishFailure
});




}
/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._self, this._then);

  final OnboardingState _self;
  final $Res Function(OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageIndex = null,Object? dietaryPreference = null,Object? finishStatus = null,Object? finishFailure = freezed,}) {
  return _then(_self.copyWith(
pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,dietaryPreference: null == dietaryPreference ? _self.dietaryPreference : dietaryPreference // ignore: cast_nullable_to_non_nullable
as DietaryPreference,finishStatus: null == finishStatus ? _self.finishStatus : finishStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,finishFailure: freezed == finishFailure ? _self.finishFailure : finishFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pageIndex,  DietaryPreference dietaryPreference,  BlocStatus finishStatus,  Failure? finishFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.pageIndex,_that.dietaryPreference,_that.finishStatus,_that.finishFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pageIndex,  DietaryPreference dietaryPreference,  BlocStatus finishStatus,  Failure? finishFailure)  $default,) {final _that = this;
switch (_that) {
case _OnboardingState():
return $default(_that.pageIndex,_that.dietaryPreference,_that.finishStatus,_that.finishFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pageIndex,  DietaryPreference dietaryPreference,  BlocStatus finishStatus,  Failure? finishFailure)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.pageIndex,_that.dietaryPreference,_that.finishStatus,_that.finishFailure);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingState implements OnboardingState {
  const _OnboardingState({this.pageIndex = 0, this.dietaryPreference = DietaryPreference.none, this.finishStatus = BlocStatus.initial, this.finishFailure});
  

/// The page currently in view, mirrored from the [PageView] so the dots and
/// the primary button stay in sync.
@override@JsonKey() final  int pageIndex;
/// The dietary preference chosen on the setup page (defaults to "no
/// restriction" until the user picks one).
@override@JsonKey() final  DietaryPreference dietaryPreference;
/// Tracks persisting the completion flag when the user finishes.
@override@JsonKey() final  BlocStatus finishStatus;
@override final  Failure? finishFailure;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateCopyWith<_OnboardingState> get copyWith => __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingState&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.dietaryPreference, dietaryPreference) || other.dietaryPreference == dietaryPreference)&&(identical(other.finishStatus, finishStatus) || other.finishStatus == finishStatus)&&(identical(other.finishFailure, finishFailure) || other.finishFailure == finishFailure));
}


@override
int get hashCode => Object.hash(runtimeType,pageIndex,dietaryPreference,finishStatus,finishFailure);

@override
String toString() {
  return 'OnboardingState(pageIndex: $pageIndex, dietaryPreference: $dietaryPreference, finishStatus: $finishStatus, finishFailure: $finishFailure)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(_OnboardingState value, $Res Function(_OnboardingState) _then) = __$OnboardingStateCopyWithImpl;
@override @useResult
$Res call({
 int pageIndex, DietaryPreference dietaryPreference, BlocStatus finishStatus, Failure? finishFailure
});




}
/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageIndex = null,Object? dietaryPreference = null,Object? finishStatus = null,Object? finishFailure = freezed,}) {
  return _then(_OnboardingState(
pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,dietaryPreference: null == dietaryPreference ? _self.dietaryPreference : dietaryPreference // ignore: cast_nullable_to_non_nullable
as DietaryPreference,finishStatus: null == finishStatus ? _self.finishStatus : finishStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,finishFailure: freezed == finishFailure ? _self.finishFailure : finishFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
