// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeModel {

@JsonKey(name: 'title') String? get title;@JsonKey(name: 'description') String? get description;@JsonKey(name: 'servings') int? get servings;@JsonKey(name: 'cook_time_minutes') int? get cookTimeMinutes;// `mood` is a generation *input*, not part of the model's response JSON, so
// it's excluded from fromJson. It IS written to toJson, though, so the
// detail cache (which persists toJson and re-reads it) keeps the mood.
@JsonKey(name: 'mood', includeFromJson: false, includeToJson: true) String? get mood;@JsonKey(name: 'ingredients') List<RecipeIngredientModel> get ingredients;@JsonKey(name: 'steps') List<RecipeStepModel> get steps;
/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeModelCopyWith<RecipeModel> get copyWith => _$RecipeModelCopyWithImpl<RecipeModel>(this as RecipeModel, _$identity);

  /// Serializes this RecipeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.servings, servings) || other.servings == servings)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other.ingredients, ingredients)&&const DeepCollectionEquality().equals(other.steps, steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,servings,cookTimeMinutes,mood,const DeepCollectionEquality().hash(ingredients),const DeepCollectionEquality().hash(steps));

@override
String toString() {
  return 'RecipeModel(title: $title, description: $description, servings: $servings, cookTimeMinutes: $cookTimeMinutes, mood: $mood, ingredients: $ingredients, steps: $steps)';
}


}

/// @nodoc
abstract mixin class $RecipeModelCopyWith<$Res>  {
  factory $RecipeModelCopyWith(RecipeModel value, $Res Function(RecipeModel) _then) = _$RecipeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'title') String? title,@JsonKey(name: 'description') String? description,@JsonKey(name: 'servings') int? servings,@JsonKey(name: 'cook_time_minutes') int? cookTimeMinutes,@JsonKey(name: 'mood', includeFromJson: false, includeToJson: true) String? mood,@JsonKey(name: 'ingredients') List<RecipeIngredientModel> ingredients,@JsonKey(name: 'steps') List<RecipeStepModel> steps
});




}
/// @nodoc
class _$RecipeModelCopyWithImpl<$Res>
    implements $RecipeModelCopyWith<$Res> {
  _$RecipeModelCopyWithImpl(this._self, this._then);

  final RecipeModel _self;
  final $Res Function(RecipeModel) _then;

/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? servings = freezed,Object? cookTimeMinutes = freezed,Object? mood = freezed,Object? ingredients = null,Object? steps = null,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,servings: freezed == servings ? _self.servings : servings // ignore: cast_nullable_to_non_nullable
as int?,cookTimeMinutes: freezed == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredientModel>,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStepModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeModel].
extension RecipeModelPatterns on RecipeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeModel value)  $default,){
final _that = this;
switch (_that) {
case _RecipeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'title')  String? title, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'servings')  int? servings, @JsonKey(name: 'cook_time_minutes')  int? cookTimeMinutes, @JsonKey(name: 'mood', includeFromJson: false, includeToJson: true)  String? mood, @JsonKey(name: 'ingredients')  List<RecipeIngredientModel> ingredients, @JsonKey(name: 'steps')  List<RecipeStepModel> steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
return $default(_that.title,_that.description,_that.servings,_that.cookTimeMinutes,_that.mood,_that.ingredients,_that.steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'title')  String? title, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'servings')  int? servings, @JsonKey(name: 'cook_time_minutes')  int? cookTimeMinutes, @JsonKey(name: 'mood', includeFromJson: false, includeToJson: true)  String? mood, @JsonKey(name: 'ingredients')  List<RecipeIngredientModel> ingredients, @JsonKey(name: 'steps')  List<RecipeStepModel> steps)  $default,) {final _that = this;
switch (_that) {
case _RecipeModel():
return $default(_that.title,_that.description,_that.servings,_that.cookTimeMinutes,_that.mood,_that.ingredients,_that.steps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'title')  String? title, @JsonKey(name: 'description')  String? description, @JsonKey(name: 'servings')  int? servings, @JsonKey(name: 'cook_time_minutes')  int? cookTimeMinutes, @JsonKey(name: 'mood', includeFromJson: false, includeToJson: true)  String? mood, @JsonKey(name: 'ingredients')  List<RecipeIngredientModel> ingredients, @JsonKey(name: 'steps')  List<RecipeStepModel> steps)?  $default,) {final _that = this;
switch (_that) {
case _RecipeModel() when $default != null:
return $default(_that.title,_that.description,_that.servings,_that.cookTimeMinutes,_that.mood,_that.ingredients,_that.steps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecipeModel implements RecipeModel {
   _RecipeModel({@JsonKey(name: 'title') this.title, @JsonKey(name: 'description') this.description, @JsonKey(name: 'servings') this.servings, @JsonKey(name: 'cook_time_minutes') this.cookTimeMinutes, @JsonKey(name: 'mood', includeFromJson: false, includeToJson: true) this.mood, @JsonKey(name: 'ingredients') final  List<RecipeIngredientModel> ingredients = const <RecipeIngredientModel>[], @JsonKey(name: 'steps') final  List<RecipeStepModel> steps = const <RecipeStepModel>[]}): _ingredients = ingredients,_steps = steps;
  factory _RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);

@override@JsonKey(name: 'title') final  String? title;
@override@JsonKey(name: 'description') final  String? description;
@override@JsonKey(name: 'servings') final  int? servings;
@override@JsonKey(name: 'cook_time_minutes') final  int? cookTimeMinutes;
// `mood` is a generation *input*, not part of the model's response JSON, so
// it's excluded from fromJson. It IS written to toJson, though, so the
// detail cache (which persists toJson and re-reads it) keeps the mood.
@override@JsonKey(name: 'mood', includeFromJson: false, includeToJson: true) final  String? mood;
 final  List<RecipeIngredientModel> _ingredients;
@override@JsonKey(name: 'ingredients') List<RecipeIngredientModel> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}

 final  List<RecipeStepModel> _steps;
@override@JsonKey(name: 'steps') List<RecipeStepModel> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}


/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeModelCopyWith<_RecipeModel> get copyWith => __$RecipeModelCopyWithImpl<_RecipeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecipeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.servings, servings) || other.servings == servings)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients)&&const DeepCollectionEquality().equals(other._steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,servings,cookTimeMinutes,mood,const DeepCollectionEquality().hash(_ingredients),const DeepCollectionEquality().hash(_steps));

@override
String toString() {
  return 'RecipeModel(title: $title, description: $description, servings: $servings, cookTimeMinutes: $cookTimeMinutes, mood: $mood, ingredients: $ingredients, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$RecipeModelCopyWith<$Res> implements $RecipeModelCopyWith<$Res> {
  factory _$RecipeModelCopyWith(_RecipeModel value, $Res Function(_RecipeModel) _then) = __$RecipeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'title') String? title,@JsonKey(name: 'description') String? description,@JsonKey(name: 'servings') int? servings,@JsonKey(name: 'cook_time_minutes') int? cookTimeMinutes,@JsonKey(name: 'mood', includeFromJson: false, includeToJson: true) String? mood,@JsonKey(name: 'ingredients') List<RecipeIngredientModel> ingredients,@JsonKey(name: 'steps') List<RecipeStepModel> steps
});




}
/// @nodoc
class __$RecipeModelCopyWithImpl<$Res>
    implements _$RecipeModelCopyWith<$Res> {
  __$RecipeModelCopyWithImpl(this._self, this._then);

  final _RecipeModel _self;
  final $Res Function(_RecipeModel) _then;

/// Create a copy of RecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? servings = freezed,Object? cookTimeMinutes = freezed,Object? mood = freezed,Object? ingredients = null,Object? steps = null,}) {
  return _then(_RecipeModel(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,servings: freezed == servings ? _self.servings : servings // ignore: cast_nullable_to_non_nullable
as int?,cookTimeMinutes: freezed == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeIngredientModel>,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<RecipeStepModel>,
  ));
}


}

// dart format on
