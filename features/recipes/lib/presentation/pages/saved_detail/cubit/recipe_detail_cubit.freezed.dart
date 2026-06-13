// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeDetailState {

/// Drives the page: the loading spinner, the recipe ([success]) or the
/// error state (offline with nothing cached, or a fetch failure).
 BlocStatus get status;/// The loaded recipe, set once [status] is [BlocStatus.success].
 RecipeEntity? get recipe;/// Set when [status] is [BlocStatus.error].
 Failure? get failure;
/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeDetailStateCopyWith<RecipeDetailState> get copyWith => _$RecipeDetailStateCopyWithImpl<RecipeDetailState>(this as RecipeDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,recipe,failure);

@override
String toString() {
  return 'RecipeDetailState(status: $status, recipe: $recipe, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RecipeDetailStateCopyWith<$Res>  {
  factory $RecipeDetailStateCopyWith(RecipeDetailState value, $Res Function(RecipeDetailState) _then) = _$RecipeDetailStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus status, RecipeEntity? recipe, Failure? failure
});


$RecipeEntityCopyWith<$Res>? get recipe;

}
/// @nodoc
class _$RecipeDetailStateCopyWithImpl<$Res>
    implements $RecipeDetailStateCopyWith<$Res> {
  _$RecipeDetailStateCopyWithImpl(this._self, this._then);

  final RecipeDetailState _self;
  final $Res Function(RecipeDetailState) _then;

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? recipe = freezed,Object? failure = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,recipe: freezed == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as RecipeEntity?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeEntityCopyWith<$Res>? get recipe {
    if (_self.recipe == null) {
    return null;
  }

  return $RecipeEntityCopyWith<$Res>(_self.recipe!, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecipeDetailState].
extension RecipeDetailStatePatterns on RecipeDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeDetailState value)  $default,){
final _that = this;
switch (_that) {
case _RecipeDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus status,  RecipeEntity? recipe,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeDetailState() when $default != null:
return $default(_that.status,_that.recipe,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus status,  RecipeEntity? recipe,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RecipeDetailState():
return $default(_that.status,_that.recipe,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus status,  RecipeEntity? recipe,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RecipeDetailState() when $default != null:
return $default(_that.status,_that.recipe,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeDetailState implements RecipeDetailState {
  const _RecipeDetailState({this.status = BlocStatus.initial, this.recipe, this.failure});
  

/// Drives the page: the loading spinner, the recipe ([success]) or the
/// error state (offline with nothing cached, or a fetch failure).
@override@JsonKey() final  BlocStatus status;
/// The loaded recipe, set once [status] is [BlocStatus.success].
@override final  RecipeEntity? recipe;
/// Set when [status] is [BlocStatus.error].
@override final  Failure? failure;

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeDetailStateCopyWith<_RecipeDetailState> get copyWith => __$RecipeDetailStateCopyWithImpl<_RecipeDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.recipe, recipe) || other.recipe == recipe)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,recipe,failure);

@override
String toString() {
  return 'RecipeDetailState(status: $status, recipe: $recipe, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RecipeDetailStateCopyWith<$Res> implements $RecipeDetailStateCopyWith<$Res> {
  factory _$RecipeDetailStateCopyWith(_RecipeDetailState value, $Res Function(_RecipeDetailState) _then) = __$RecipeDetailStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus status, RecipeEntity? recipe, Failure? failure
});


@override $RecipeEntityCopyWith<$Res>? get recipe;

}
/// @nodoc
class __$RecipeDetailStateCopyWithImpl<$Res>
    implements _$RecipeDetailStateCopyWith<$Res> {
  __$RecipeDetailStateCopyWithImpl(this._self, this._then);

  final _RecipeDetailState _self;
  final $Res Function(_RecipeDetailState) _then;

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? recipe = freezed,Object? failure = freezed,}) {
  return _then(_RecipeDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,recipe: freezed == recipe ? _self.recipe : recipe // ignore: cast_nullable_to_non_nullable
as RecipeEntity?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of RecipeDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecipeEntityCopyWith<$Res>? get recipe {
    if (_self.recipe == null) {
    return null;
  }

  return $RecipeEntityCopyWith<$Res>(_self.recipe!, (value) {
    return _then(_self.copyWith(recipe: value));
  });
}
}

// dart format on
