// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedRecipeModel {

 String get id; String get title; DateTime get savedAt; int? get cookTimeMinutes; String? get mood; int get rating;
/// Create a copy of SavedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedRecipeModelCopyWith<SavedRecipeModel> get copyWith => _$SavedRecipeModelCopyWithImpl<SavedRecipeModel>(this as SavedRecipeModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedRecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,savedAt,cookTimeMinutes,mood,rating);

@override
String toString() {
  return 'SavedRecipeModel(id: $id, title: $title, savedAt: $savedAt, cookTimeMinutes: $cookTimeMinutes, mood: $mood, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $SavedRecipeModelCopyWith<$Res>  {
  factory $SavedRecipeModelCopyWith(SavedRecipeModel value, $Res Function(SavedRecipeModel) _then) = _$SavedRecipeModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime savedAt, int? cookTimeMinutes, String? mood, int rating
});




}
/// @nodoc
class _$SavedRecipeModelCopyWithImpl<$Res>
    implements $SavedRecipeModelCopyWith<$Res> {
  _$SavedRecipeModelCopyWithImpl(this._self, this._then);

  final SavedRecipeModel _self;
  final $Res Function(SavedRecipeModel) _then;

/// Create a copy of SavedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? savedAt = null,Object? cookTimeMinutes = freezed,Object? mood = freezed,Object? rating = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cookTimeMinutes: freezed == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedRecipeModel].
extension SavedRecipeModelPatterns on SavedRecipeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedRecipeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedRecipeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedRecipeModel value)  $default,){
final _that = this;
switch (_that) {
case _SavedRecipeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedRecipeModel value)?  $default,){
final _that = this;
switch (_that) {
case _SavedRecipeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime savedAt,  int? cookTimeMinutes,  String? mood,  int rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedRecipeModel() when $default != null:
return $default(_that.id,_that.title,_that.savedAt,_that.cookTimeMinutes,_that.mood,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime savedAt,  int? cookTimeMinutes,  String? mood,  int rating)  $default,) {final _that = this;
switch (_that) {
case _SavedRecipeModel():
return $default(_that.id,_that.title,_that.savedAt,_that.cookTimeMinutes,_that.mood,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime savedAt,  int? cookTimeMinutes,  String? mood,  int rating)?  $default,) {final _that = this;
switch (_that) {
case _SavedRecipeModel() when $default != null:
return $default(_that.id,_that.title,_that.savedAt,_that.cookTimeMinutes,_that.mood,_that.rating);case _:
  return null;

}
}

}

/// @nodoc


class _SavedRecipeModel implements SavedRecipeModel {
   _SavedRecipeModel({required this.id, required this.title, required this.savedAt, this.cookTimeMinutes, this.mood, this.rating = 0});
  

@override final  String id;
@override final  String title;
@override final  DateTime savedAt;
@override final  int? cookTimeMinutes;
@override final  String? mood;
@override@JsonKey() final  int rating;

/// Create a copy of SavedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedRecipeModelCopyWith<_SavedRecipeModel> get copyWith => __$SavedRecipeModelCopyWithImpl<_SavedRecipeModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedRecipeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,savedAt,cookTimeMinutes,mood,rating);

@override
String toString() {
  return 'SavedRecipeModel(id: $id, title: $title, savedAt: $savedAt, cookTimeMinutes: $cookTimeMinutes, mood: $mood, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$SavedRecipeModelCopyWith<$Res> implements $SavedRecipeModelCopyWith<$Res> {
  factory _$SavedRecipeModelCopyWith(_SavedRecipeModel value, $Res Function(_SavedRecipeModel) _then) = __$SavedRecipeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime savedAt, int? cookTimeMinutes, String? mood, int rating
});




}
/// @nodoc
class __$SavedRecipeModelCopyWithImpl<$Res>
    implements _$SavedRecipeModelCopyWith<$Res> {
  __$SavedRecipeModelCopyWithImpl(this._self, this._then);

  final _SavedRecipeModel _self;
  final $Res Function(_SavedRecipeModel) _then;

/// Create a copy of SavedRecipeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? savedAt = null,Object? cookTimeMinutes = freezed,Object? mood = freezed,Object? rating = null,}) {
  return _then(_SavedRecipeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,savedAt: null == savedAt ? _self.savedAt : savedAt // ignore: cast_nullable_to_non_nullable
as DateTime,cookTimeMinutes: freezed == cookTimeMinutes ? _self.cookTimeMinutes : cookTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
