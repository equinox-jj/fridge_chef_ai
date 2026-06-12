// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_step_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeStepEntity {

 int get stepNumber; String get instruction; int? get timerSeconds;
/// Create a copy of RecipeStepEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeStepEntityCopyWith<RecipeStepEntity> get copyWith => _$RecipeStepEntityCopyWithImpl<RecipeStepEntity>(this as RecipeStepEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeStepEntity&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.timerSeconds, timerSeconds) || other.timerSeconds == timerSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,stepNumber,instruction,timerSeconds);

@override
String toString() {
  return 'RecipeStepEntity(stepNumber: $stepNumber, instruction: $instruction, timerSeconds: $timerSeconds)';
}


}

/// @nodoc
abstract mixin class $RecipeStepEntityCopyWith<$Res>  {
  factory $RecipeStepEntityCopyWith(RecipeStepEntity value, $Res Function(RecipeStepEntity) _then) = _$RecipeStepEntityCopyWithImpl;
@useResult
$Res call({
 int stepNumber, String instruction, int? timerSeconds
});




}
/// @nodoc
class _$RecipeStepEntityCopyWithImpl<$Res>
    implements $RecipeStepEntityCopyWith<$Res> {
  _$RecipeStepEntityCopyWithImpl(this._self, this._then);

  final RecipeStepEntity _self;
  final $Res Function(RecipeStepEntity) _then;

/// Create a copy of RecipeStepEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stepNumber = null,Object? instruction = null,Object? timerSeconds = freezed,}) {
  return _then(_self.copyWith(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,timerSeconds: freezed == timerSeconds ? _self.timerSeconds : timerSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeStepEntity].
extension RecipeStepEntityPatterns on RecipeStepEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeStepEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeStepEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeStepEntity value)  $default,){
final _that = this;
switch (_that) {
case _RecipeStepEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeStepEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeStepEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stepNumber,  String instruction,  int? timerSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeStepEntity() when $default != null:
return $default(_that.stepNumber,_that.instruction,_that.timerSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stepNumber,  String instruction,  int? timerSeconds)  $default,) {final _that = this;
switch (_that) {
case _RecipeStepEntity():
return $default(_that.stepNumber,_that.instruction,_that.timerSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stepNumber,  String instruction,  int? timerSeconds)?  $default,) {final _that = this;
switch (_that) {
case _RecipeStepEntity() when $default != null:
return $default(_that.stepNumber,_that.instruction,_that.timerSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeStepEntity implements RecipeStepEntity {
   _RecipeStepEntity({required this.stepNumber, required this.instruction, this.timerSeconds});
  

@override final  int stepNumber;
@override final  String instruction;
@override final  int? timerSeconds;

/// Create a copy of RecipeStepEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeStepEntityCopyWith<_RecipeStepEntity> get copyWith => __$RecipeStepEntityCopyWithImpl<_RecipeStepEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeStepEntity&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.instruction, instruction) || other.instruction == instruction)&&(identical(other.timerSeconds, timerSeconds) || other.timerSeconds == timerSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,stepNumber,instruction,timerSeconds);

@override
String toString() {
  return 'RecipeStepEntity(stepNumber: $stepNumber, instruction: $instruction, timerSeconds: $timerSeconds)';
}


}

/// @nodoc
abstract mixin class _$RecipeStepEntityCopyWith<$Res> implements $RecipeStepEntityCopyWith<$Res> {
  factory _$RecipeStepEntityCopyWith(_RecipeStepEntity value, $Res Function(_RecipeStepEntity) _then) = __$RecipeStepEntityCopyWithImpl;
@override @useResult
$Res call({
 int stepNumber, String instruction, int? timerSeconds
});




}
/// @nodoc
class __$RecipeStepEntityCopyWithImpl<$Res>
    implements _$RecipeStepEntityCopyWith<$Res> {
  __$RecipeStepEntityCopyWithImpl(this._self, this._then);

  final _RecipeStepEntity _self;
  final $Res Function(_RecipeStepEntity) _then;

/// Create a copy of RecipeStepEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stepNumber = null,Object? instruction = null,Object? timerSeconds = freezed,}) {
  return _then(_RecipeStepEntity(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,instruction: null == instruction ? _self.instruction : instruction // ignore: cast_nullable_to_non_nullable
as String,timerSeconds: freezed == timerSeconds ? _self.timerSeconds : timerSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
