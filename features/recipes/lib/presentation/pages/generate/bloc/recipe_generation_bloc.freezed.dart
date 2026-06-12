// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_generation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeGenerationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeGenerationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipeGenerationEvent()';
}


}

/// @nodoc
class $RecipeGenerationEventCopyWith<$Res>  {
$RecipeGenerationEventCopyWith(RecipeGenerationEvent _, $Res Function(RecipeGenerationEvent) __);
}


/// Adds pattern-matching-related methods to [RecipeGenerationEvent].
extension RecipeGenerationEventPatterns on RecipeGenerationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _MoodSelected value)?  moodSelected,TResult Function( _GenerateRequested value)?  generateRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MoodSelected() when moodSelected != null:
return moodSelected(_that);case _GenerateRequested() when generateRequested != null:
return generateRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _MoodSelected value)  moodSelected,required TResult Function( _GenerateRequested value)  generateRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _MoodSelected():
return moodSelected(_that);case _GenerateRequested():
return generateRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _MoodSelected value)?  moodSelected,TResult? Function( _GenerateRequested value)?  generateRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MoodSelected() when moodSelected != null:
return moodSelected(_that);case _GenerateRequested() when generateRequested != null:
return generateRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( RecipeMood mood)?  moodSelected,TResult Function()?  generateRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _MoodSelected() when moodSelected != null:
return moodSelected(_that.mood);case _GenerateRequested() when generateRequested != null:
return generateRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( RecipeMood mood)  moodSelected,required TResult Function()  generateRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _MoodSelected():
return moodSelected(_that.mood);case _GenerateRequested():
return generateRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( RecipeMood mood)?  moodSelected,TResult? Function()?  generateRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _MoodSelected() when moodSelected != null:
return moodSelected(_that.mood);case _GenerateRequested() when generateRequested != null:
return generateRequested();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements RecipeGenerationEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipeGenerationEvent.started()';
}


}




/// @nodoc


class _MoodSelected implements RecipeGenerationEvent {
  const _MoodSelected(this.mood);
  

 final  RecipeMood mood;

/// Create a copy of RecipeGenerationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoodSelectedCopyWith<_MoodSelected> get copyWith => __$MoodSelectedCopyWithImpl<_MoodSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoodSelected&&(identical(other.mood, mood) || other.mood == mood));
}


@override
int get hashCode => Object.hash(runtimeType,mood);

@override
String toString() {
  return 'RecipeGenerationEvent.moodSelected(mood: $mood)';
}


}

/// @nodoc
abstract mixin class _$MoodSelectedCopyWith<$Res> implements $RecipeGenerationEventCopyWith<$Res> {
  factory _$MoodSelectedCopyWith(_MoodSelected value, $Res Function(_MoodSelected) _then) = __$MoodSelectedCopyWithImpl;
@useResult
$Res call({
 RecipeMood mood
});




}
/// @nodoc
class __$MoodSelectedCopyWithImpl<$Res>
    implements _$MoodSelectedCopyWith<$Res> {
  __$MoodSelectedCopyWithImpl(this._self, this._then);

  final _MoodSelected _self;
  final $Res Function(_MoodSelected) _then;

/// Create a copy of RecipeGenerationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mood = null,}) {
  return _then(_MoodSelected(
null == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as RecipeMood,
  ));
}


}

/// @nodoc


class _GenerateRequested implements RecipeGenerationEvent {
  const _GenerateRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RecipeGenerationEvent.generateRequested()';
}


}




/// @nodoc
mixin _$RecipeGenerationState {

/// Reviewed ingredients to build recipes from (fixed for this flow).
 List<RecipeSeedIngredient> get ingredients;/// Originating scan id, threaded through to a saved recipe.
 String? get scanId;/// Dietary preference pre-filled from the profile; defaults to none.
 DietaryPreference get dietaryPreference;/// The currently selected mood, or null until the user picks one.
 RecipeMood? get mood;/// Current screen of the flow.
 RecipeGenStatus get status;/// The generated recipes, once available.
 List<RecipeEntity> get recipes;/// Why the last generation failed, when [status] is [RecipeGenStatus.error].
 Failure? get failure;
/// Create a copy of RecipeGenerationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeGenerationStateCopyWith<RecipeGenerationState> get copyWith => _$RecipeGenerationStateCopyWithImpl<RecipeGenerationState>(this as RecipeGenerationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeGenerationState&&const DeepCollectionEquality().equals(other.ingredients, ingredients)&&(identical(other.scanId, scanId) || other.scanId == scanId)&&(identical(other.dietaryPreference, dietaryPreference) || other.dietaryPreference == dietaryPreference)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.recipes, recipes)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(ingredients),scanId,dietaryPreference,mood,status,const DeepCollectionEquality().hash(recipes),failure);

@override
String toString() {
  return 'RecipeGenerationState(ingredients: $ingredients, scanId: $scanId, dietaryPreference: $dietaryPreference, mood: $mood, status: $status, recipes: $recipes, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RecipeGenerationStateCopyWith<$Res>  {
  factory $RecipeGenerationStateCopyWith(RecipeGenerationState value, $Res Function(RecipeGenerationState) _then) = _$RecipeGenerationStateCopyWithImpl;
@useResult
$Res call({
 List<RecipeSeedIngredient> ingredients, String? scanId, DietaryPreference dietaryPreference, RecipeMood? mood, RecipeGenStatus status, List<RecipeEntity> recipes, Failure? failure
});




}
/// @nodoc
class _$RecipeGenerationStateCopyWithImpl<$Res>
    implements $RecipeGenerationStateCopyWith<$Res> {
  _$RecipeGenerationStateCopyWithImpl(this._self, this._then);

  final RecipeGenerationState _self;
  final $Res Function(RecipeGenerationState) _then;

/// Create a copy of RecipeGenerationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ingredients = null,Object? scanId = freezed,Object? dietaryPreference = null,Object? mood = freezed,Object? status = null,Object? recipes = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeSeedIngredient>,scanId: freezed == scanId ? _self.scanId : scanId // ignore: cast_nullable_to_non_nullable
as String?,dietaryPreference: null == dietaryPreference ? _self.dietaryPreference : dietaryPreference // ignore: cast_nullable_to_non_nullable
as DietaryPreference,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as RecipeMood?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecipeGenStatus,recipes: null == recipes ? _self.recipes : recipes // ignore: cast_nullable_to_non_nullable
as List<RecipeEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeGenerationState].
extension RecipeGenerationStatePatterns on RecipeGenerationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeGenerationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeGenerationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeGenerationState value)  $default,){
final _that = this;
switch (_that) {
case _RecipeGenerationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeGenerationState value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeGenerationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RecipeSeedIngredient> ingredients,  String? scanId,  DietaryPreference dietaryPreference,  RecipeMood? mood,  RecipeGenStatus status,  List<RecipeEntity> recipes,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeGenerationState() when $default != null:
return $default(_that.ingredients,_that.scanId,_that.dietaryPreference,_that.mood,_that.status,_that.recipes,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RecipeSeedIngredient> ingredients,  String? scanId,  DietaryPreference dietaryPreference,  RecipeMood? mood,  RecipeGenStatus status,  List<RecipeEntity> recipes,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RecipeGenerationState():
return $default(_that.ingredients,_that.scanId,_that.dietaryPreference,_that.mood,_that.status,_that.recipes,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RecipeSeedIngredient> ingredients,  String? scanId,  DietaryPreference dietaryPreference,  RecipeMood? mood,  RecipeGenStatus status,  List<RecipeEntity> recipes,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RecipeGenerationState() when $default != null:
return $default(_that.ingredients,_that.scanId,_that.dietaryPreference,_that.mood,_that.status,_that.recipes,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeGenerationState implements RecipeGenerationState {
  const _RecipeGenerationState({final  List<RecipeSeedIngredient> ingredients = const <RecipeSeedIngredient>[], this.scanId, this.dietaryPreference = DietaryPreference.none, this.mood, this.status = RecipeGenStatus.selecting, final  List<RecipeEntity> recipes = const <RecipeEntity>[], this.failure}): _ingredients = ingredients,_recipes = recipes;
  

/// Reviewed ingredients to build recipes from (fixed for this flow).
 final  List<RecipeSeedIngredient> _ingredients;
/// Reviewed ingredients to build recipes from (fixed for this flow).
@override@JsonKey() List<RecipeSeedIngredient> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}

/// Originating scan id, threaded through to a saved recipe.
@override final  String? scanId;
/// Dietary preference pre-filled from the profile; defaults to none.
@override@JsonKey() final  DietaryPreference dietaryPreference;
/// The currently selected mood, or null until the user picks one.
@override final  RecipeMood? mood;
/// Current screen of the flow.
@override@JsonKey() final  RecipeGenStatus status;
/// The generated recipes, once available.
 final  List<RecipeEntity> _recipes;
/// The generated recipes, once available.
@override@JsonKey() List<RecipeEntity> get recipes {
  if (_recipes is EqualUnmodifiableListView) return _recipes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipes);
}

/// Why the last generation failed, when [status] is [RecipeGenStatus.error].
@override final  Failure? failure;

/// Create a copy of RecipeGenerationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeGenerationStateCopyWith<_RecipeGenerationState> get copyWith => __$RecipeGenerationStateCopyWithImpl<_RecipeGenerationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeGenerationState&&const DeepCollectionEquality().equals(other._ingredients, _ingredients)&&(identical(other.scanId, scanId) || other.scanId == scanId)&&(identical(other.dietaryPreference, dietaryPreference) || other.dietaryPreference == dietaryPreference)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._recipes, _recipes)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_ingredients),scanId,dietaryPreference,mood,status,const DeepCollectionEquality().hash(_recipes),failure);

@override
String toString() {
  return 'RecipeGenerationState(ingredients: $ingredients, scanId: $scanId, dietaryPreference: $dietaryPreference, mood: $mood, status: $status, recipes: $recipes, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RecipeGenerationStateCopyWith<$Res> implements $RecipeGenerationStateCopyWith<$Res> {
  factory _$RecipeGenerationStateCopyWith(_RecipeGenerationState value, $Res Function(_RecipeGenerationState) _then) = __$RecipeGenerationStateCopyWithImpl;
@override @useResult
$Res call({
 List<RecipeSeedIngredient> ingredients, String? scanId, DietaryPreference dietaryPreference, RecipeMood? mood, RecipeGenStatus status, List<RecipeEntity> recipes, Failure? failure
});




}
/// @nodoc
class __$RecipeGenerationStateCopyWithImpl<$Res>
    implements _$RecipeGenerationStateCopyWith<$Res> {
  __$RecipeGenerationStateCopyWithImpl(this._self, this._then);

  final _RecipeGenerationState _self;
  final $Res Function(_RecipeGenerationState) _then;

/// Create a copy of RecipeGenerationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ingredients = null,Object? scanId = freezed,Object? dietaryPreference = null,Object? mood = freezed,Object? status = null,Object? recipes = null,Object? failure = freezed,}) {
  return _then(_RecipeGenerationState(
ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<RecipeSeedIngredient>,scanId: freezed == scanId ? _self.scanId : scanId // ignore: cast_nullable_to_non_nullable
as String?,dietaryPreference: null == dietaryPreference ? _self.dietaryPreference : dietaryPreference // ignore: cast_nullable_to_non_nullable
as DietaryPreference,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as RecipeMood?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecipeGenStatus,recipes: null == recipes ? _self._recipes : recipes // ignore: cast_nullable_to_non_nullable
as List<RecipeEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
