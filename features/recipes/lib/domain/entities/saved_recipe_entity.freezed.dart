// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_recipe_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedRecipeEntity {

 String get id; String get title; DateTime get savedAt; int? get cookTimeMinutes; String? get mood; int get rating;
/// Create a copy of SavedRecipeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedRecipeEntityCopyWith<SavedRecipeEntity> get copyWith => _$SavedRecipeEntityCopyWithImpl<SavedRecipeEntity>(this as SavedRecipeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedRecipeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,savedAt,cookTimeMinutes,mood,rating);

@override
String toString() {
  return 'SavedRecipeEntity(id: $id, title: $title, savedAt: $savedAt, cookTimeMinutes: $cookTimeMinutes, mood: $mood, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $SavedRecipeEntityCopyWith<$Res>  {
  factory $SavedRecipeEntityCopyWith(SavedRecipeEntity value, $Res Function(SavedRecipeEntity) _then) = _$SavedRecipeEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime savedAt, int? cookTimeMinutes, String? mood, int rating
});




}
/// @nodoc
class _$SavedRecipeEntityCopyWithImpl<$Res>
    implements $SavedRecipeEntityCopyWith<$Res> {
  _$SavedRecipeEntityCopyWithImpl(this._self, this._then);

  final SavedRecipeEntity _self;
  final $Res Function(SavedRecipeEntity) _then;

/// Create a copy of SavedRecipeEntity
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


/// Adds pattern-matching-related methods to [SavedRecipeEntity].
extension SavedRecipeEntityPatterns on SavedRecipeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedRecipeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedRecipeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedRecipeEntity value)  $default,){
final _that = this;
switch (_that) {
case _SavedRecipeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedRecipeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SavedRecipeEntity() when $default != null:
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
case _SavedRecipeEntity() when $default != null:
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
case _SavedRecipeEntity():
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
case _SavedRecipeEntity() when $default != null:
return $default(_that.id,_that.title,_that.savedAt,_that.cookTimeMinutes,_that.mood,_that.rating);case _:
  return null;

}
}

}

/// @nodoc


class _SavedRecipeEntity implements SavedRecipeEntity {
   _SavedRecipeEntity({required this.id, required this.title, required this.savedAt, this.cookTimeMinutes, this.mood, this.rating = 0});
  

@override final  String id;
@override final  String title;
@override final  DateTime savedAt;
@override final  int? cookTimeMinutes;
@override final  String? mood;
@override@JsonKey() final  int rating;

/// Create a copy of SavedRecipeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedRecipeEntityCopyWith<_SavedRecipeEntity> get copyWith => __$SavedRecipeEntityCopyWithImpl<_SavedRecipeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedRecipeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.savedAt, savedAt) || other.savedAt == savedAt)&&(identical(other.cookTimeMinutes, cookTimeMinutes) || other.cookTimeMinutes == cookTimeMinutes)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,savedAt,cookTimeMinutes,mood,rating);

@override
String toString() {
  return 'SavedRecipeEntity(id: $id, title: $title, savedAt: $savedAt, cookTimeMinutes: $cookTimeMinutes, mood: $mood, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$SavedRecipeEntityCopyWith<$Res> implements $SavedRecipeEntityCopyWith<$Res> {
  factory _$SavedRecipeEntityCopyWith(_SavedRecipeEntity value, $Res Function(_SavedRecipeEntity) _then) = __$SavedRecipeEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime savedAt, int? cookTimeMinutes, String? mood, int rating
});




}
/// @nodoc
class __$SavedRecipeEntityCopyWithImpl<$Res>
    implements _$SavedRecipeEntityCopyWith<$Res> {
  __$SavedRecipeEntityCopyWithImpl(this._self, this._then);

  final _SavedRecipeEntity _self;
  final $Res Function(_SavedRecipeEntity) _then;

/// Create a copy of SavedRecipeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? savedAt = null,Object? cookTimeMinutes = freezed,Object? mood = freezed,Object? rating = null,}) {
  return _then(_SavedRecipeEntity(
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
