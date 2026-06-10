// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpState {

 BlocStatus get signUpStatus; Failure? get signUpFailure; UserEntity? get signUpResponse; bool get obscurePassword;
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpStateCopyWith<SignUpState> get copyWith => _$SignUpStateCopyWithImpl<SignUpState>(this as SignUpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState&&(identical(other.signUpStatus, signUpStatus) || other.signUpStatus == signUpStatus)&&(identical(other.signUpFailure, signUpFailure) || other.signUpFailure == signUpFailure)&&(identical(other.signUpResponse, signUpResponse) || other.signUpResponse == signUpResponse)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword));
}


@override
int get hashCode => Object.hash(runtimeType,signUpStatus,signUpFailure,signUpResponse,obscurePassword);

@override
String toString() {
  return 'SignUpState(signUpStatus: $signUpStatus, signUpFailure: $signUpFailure, signUpResponse: $signUpResponse, obscurePassword: $obscurePassword)';
}


}

/// @nodoc
abstract mixin class $SignUpStateCopyWith<$Res>  {
  factory $SignUpStateCopyWith(SignUpState value, $Res Function(SignUpState) _then) = _$SignUpStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus signUpStatus, Failure? signUpFailure, UserEntity? signUpResponse, bool obscurePassword
});


$UserEntityCopyWith<$Res>? get signUpResponse;

}
/// @nodoc
class _$SignUpStateCopyWithImpl<$Res>
    implements $SignUpStateCopyWith<$Res> {
  _$SignUpStateCopyWithImpl(this._self, this._then);

  final SignUpState _self;
  final $Res Function(SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signUpStatus = null,Object? signUpFailure = freezed,Object? signUpResponse = freezed,Object? obscurePassword = null,}) {
  return _then(_self.copyWith(
signUpStatus: null == signUpStatus ? _self.signUpStatus : signUpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,signUpFailure: freezed == signUpFailure ? _self.signUpFailure : signUpFailure // ignore: cast_nullable_to_non_nullable
as Failure?,signUpResponse: freezed == signUpResponse ? _self.signUpResponse : signUpResponse // ignore: cast_nullable_to_non_nullable
as UserEntity?,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get signUpResponse {
    if (_self.signUpResponse == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.signUpResponse!, (value) {
    return _then(_self.copyWith(signUpResponse: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus signUpStatus,  Failure? signUpFailure,  UserEntity? signUpResponse,  bool obscurePassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.signUpStatus,_that.signUpFailure,_that.signUpResponse,_that.obscurePassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus signUpStatus,  Failure? signUpFailure,  UserEntity? signUpResponse,  bool obscurePassword)  $default,) {final _that = this;
switch (_that) {
case _SignUpState():
return $default(_that.signUpStatus,_that.signUpFailure,_that.signUpResponse,_that.obscurePassword);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus signUpStatus,  Failure? signUpFailure,  UserEntity? signUpResponse,  bool obscurePassword)?  $default,) {final _that = this;
switch (_that) {
case _SignUpState() when $default != null:
return $default(_that.signUpStatus,_that.signUpFailure,_that.signUpResponse,_that.obscurePassword);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpState implements SignUpState {
  const _SignUpState({this.signUpStatus = BlocStatus.initial, this.signUpFailure, this.signUpResponse, this.obscurePassword = true});
  

@override@JsonKey() final  BlocStatus signUpStatus;
@override final  Failure? signUpFailure;
@override final  UserEntity? signUpResponse;
@override@JsonKey() final  bool obscurePassword;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpStateCopyWith<_SignUpState> get copyWith => __$SignUpStateCopyWithImpl<_SignUpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpState&&(identical(other.signUpStatus, signUpStatus) || other.signUpStatus == signUpStatus)&&(identical(other.signUpFailure, signUpFailure) || other.signUpFailure == signUpFailure)&&(identical(other.signUpResponse, signUpResponse) || other.signUpResponse == signUpResponse)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword));
}


@override
int get hashCode => Object.hash(runtimeType,signUpStatus,signUpFailure,signUpResponse,obscurePassword);

@override
String toString() {
  return 'SignUpState(signUpStatus: $signUpStatus, signUpFailure: $signUpFailure, signUpResponse: $signUpResponse, obscurePassword: $obscurePassword)';
}


}

/// @nodoc
abstract mixin class _$SignUpStateCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory _$SignUpStateCopyWith(_SignUpState value, $Res Function(_SignUpState) _then) = __$SignUpStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus signUpStatus, Failure? signUpFailure, UserEntity? signUpResponse, bool obscurePassword
});


@override $UserEntityCopyWith<$Res>? get signUpResponse;

}
/// @nodoc
class __$SignUpStateCopyWithImpl<$Res>
    implements _$SignUpStateCopyWith<$Res> {
  __$SignUpStateCopyWithImpl(this._self, this._then);

  final _SignUpState _self;
  final $Res Function(_SignUpState) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signUpStatus = null,Object? signUpFailure = freezed,Object? signUpResponse = freezed,Object? obscurePassword = null,}) {
  return _then(_SignUpState(
signUpStatus: null == signUpStatus ? _self.signUpStatus : signUpStatus // ignore: cast_nullable_to_non_nullable
as BlocStatus,signUpFailure: freezed == signUpFailure ? _self.signUpFailure : signUpFailure // ignore: cast_nullable_to_non_nullable
as Failure?,signUpResponse: freezed == signUpResponse ? _self.signUpResponse : signUpResponse // ignore: cast_nullable_to_non_nullable
as UserEntity?,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get signUpResponse {
    if (_self.signUpResponse == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.signUpResponse!, (value) {
    return _then(_self.copyWith(signUpResponse: value));
  });
}
}

// dart format on
