// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeEntity {

 String get title; String? get id; String? get description; int? get servings; int? get cookTimeMinutes; String? get mood; List<RecipeIngredientEntity> get ingredients; List<RecipeStepEntity> get steps;
/// Create a copy of RecipeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeEntityCopyWith<RecipeEntity> get copyWith => _$RecipeEntityCopyWithImpl<RecipeEntity>(this as RecipeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.servings, servings) || other.servings == servings)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other.ingredients, ingredients)&&const DeepCollectionEquality().equals(other.steps, steps));
}


@override
int get hashCode => Object.hash(runtimeType,title,id,description,servings,cookTimeMinutes,mood,const DeepCollectionEquality().hash(ingredients),const DeepCollectionEquality().hash(steps));

@override
String toString() {
  return 'RecipeEntity(title: $title, id: $id, description: $description, servings: $servings, cookTimeMinutes: $cookTimeMinutes, mood: $mood, ingredients: $ingredients, steps: $steps)';
}


}

/// @nodoc
abstract mixin class $RecipeEntityCopyWith<$Res>  {
  factory $RecipeEntityCopyWith(RecipeEntity value, $Res Function(RecipeEntity) _then) = _$RecipeEntityCopyWithImpl;
@useResult
$Res call({
 String title, String? id, String? description, int? servings, int? cookTimeMinutes, String? mood, List<RecipeIngredientEntity> ingredients, List<RecipeStepEntity> steps
});




}
/// @nodoc
class _$RecipeEntityCopyWithImpl<$Res>
    implements $RecipeEntityCopyWith<$Res> {
  _$RecipeEntityCopyWithImpl(this._self, this._then);

  final RecipeEntity _self;
  final $Res Function(RecipeEntity) _then;

/// Create a copy of RecipeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? id = freezed,Object? description = freezed,Object? servings = freezed,Object? cookTimeMinutes = freezed,Object? mood = freezed,Object? ingredients = null,Object? steps = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,servings: freezed == servings ? _self.servings : servings // ignore: cast_nullable_to_non_nullable
as int?,cookTimeMinutes: freezed == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredientEntity>,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStepEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeEntity].
extension RecipeEntityPatterns on RecipeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeEntity value)  $default,){
final _that = this;
switch (_that) {
case _RecipeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? id,  String? description,  int? servings,  int? cookTimeMinutes,  String? mood,  List<RecipeIngredientEntity> ingredients,  List<RecipeStepEntity> steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeEntity() when $default != null:
return $default(_that.title,_that.id,_that.description,_that.servings,_that.cookTimeMinutes,_that.mood,_that.ingredients,_that.steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? id,  String? description,  int? servings,  int? cookTimeMinutes,  String? mood,  List<RecipeIngredientEntity> ingredients,  List<RecipeStepEntity> steps)  $default,) {final _that = this;
switch (_that) {
case _RecipeEntity():
return $default(_that.title,_that.id,_that.description,_that.servings,_that.cookTimeMinutes,_that.mood,_that.ingredients,_that.steps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? id,  String? description,  int? servings,  int? cookTimeMinutes,  String? mood,  List<RecipeIngredientEntity> ingredients,  List<RecipeStepEntity> steps)?  $default,) {final _that = this;
switch (_that) {
case _RecipeEntity() when $default != null:
return $default(_that.title,_that.id,_that.description,_that.servings,_that.cookTimeMinutes,_that.mood,_that.ingredients,_that.steps);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeEntity implements RecipeEntity {
   _RecipeEntity({required this.title, this.id, this.description, this.servings, this.cookTimeMinutes, this.mood, final  List<RecipeIngredientEntity> ingredients = const <RecipeIngredientEntity>[], final  List<RecipeStepEntity> steps = const <RecipeStepEntity>[]}): _ingredients = ingredients,_steps = steps;
  

@override final  String title;
@override final  String? id;
@override final  String? description;
@override final  int? servings;
@override final  int? cookTimeMinutes;
@override final  String? mood;
 final  List<RecipeIngredientEntity> _ingredients;
@override@JsonKey() List<RecipeIngredientEntity> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}

 final  List<RecipeStepEntity> _steps;
@override@JsonKey() List<RecipeStepEntity> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}


/// Create a copy of RecipeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeEntityCopyWith<_RecipeEntity> get copyWith => __$RecipeEntityCopyWithImpl<_RecipeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeEntity&&(identical(other.title, title) || other.title == title)&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.servings, servings) || other.servings == servings)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients)&&const DeepCollectionEquality().equals(other._steps, _steps));
}


@override
int get hashCode => Object.hash(runtimeType,title,id,description,servings,cookTimeMinutes,mood,const DeepCollectionEquality().hash(_ingredients),const DeepCollectionEquality().hash(_steps));

@override
String toString() {
  return 'RecipeEntity(title: $title, id: $id, description: $description, servings: $servings, cookTimeMinutes: $cookTimeMinutes, mood: $mood, ingredients: $ingredients, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$RecipeEntityCopyWith<$Res> implements $RecipeEntityCopyWith<$Res> {
  factory _$RecipeEntityCopyWith(_RecipeEntity value, $Res Function(_RecipeEntity) _then) = __$RecipeEntityCopyWithImpl;
@override @useResult
$Res call({
 String title, String? id, String? description, int? servings, int? cookTimeMinutes, String? mood, List<RecipeIngredientEntity> ingredients, List<RecipeStepEntity> steps
});




}
/// @nodoc
class __$RecipeEntityCopyWithImpl<$Res>
    implements _$RecipeEntityCopyWith<$Res> {
  __$RecipeEntityCopyWithImpl(this._self, this._then);

  final _RecipeEntity _self;
  final $Res Function(_RecipeEntity) _then;

/// Create a copy of RecipeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? id = freezed,Object? description = freezed,Object? servings = freezed,Object? cookTimeMinutes = freezed,Object? mood = freezed,Object? ingredients = null,Object? steps = null,}) {
  return _then(_RecipeEntity(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,servings: freezed == servings ? _self.servings : servings // ignore: cast_nullable_to_non_nullable
as int?,cookTimeMinutes: freezed == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredientEntity>,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStepEntity>,
  ));
}


}

// dart format on
