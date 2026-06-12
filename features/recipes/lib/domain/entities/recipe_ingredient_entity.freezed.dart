// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_ingredient_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecipeIngredientEntity {

 String? get name; String? get quantity; String? get unit; bool get isSubstitute;
/// Create a copy of RecipeIngredientEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecipeIngredientEntityCopyWith<RecipeIngredientEntity> get copyWith => _$RecipeIngredientEntityCopyWithImpl<RecipeIngredientEntity>(this as RecipeIngredientEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecipeIngredientEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.isSubstitute, isSubstitute) || other.isSubstitute == isSubstitute));
}


@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,isSubstitute);

@override
String toString() {
  return 'RecipeIngredientEntity(name: $name, quantity: $quantity, unit: $unit, isSubstitute: $isSubstitute)';
}


}

/// @nodoc
abstract mixin class $RecipeIngredientEntityCopyWith<$Res>  {
  factory $RecipeIngredientEntityCopyWith(RecipeIngredientEntity value, $Res Function(RecipeIngredientEntity) _then) = _$RecipeIngredientEntityCopyWithImpl;
@useResult
$Res call({
 String? name, String? quantity, String? unit, bool isSubstitute
});




}
/// @nodoc
class _$RecipeIngredientEntityCopyWithImpl<$Res>
    implements $RecipeIngredientEntityCopyWith<$Res> {
  _$RecipeIngredientEntityCopyWithImpl(this._self, this._then);

  final RecipeIngredientEntity _self;
  final $Res Function(RecipeIngredientEntity) _then;

/// Create a copy of RecipeIngredientEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? quantity = freezed,Object? unit = freezed,Object? isSubstitute = null,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,isSubstitute: null == isSubstitute ? _self.isSubstitute : isSubstitute // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecipeIngredientEntity].
extension RecipeIngredientEntityPatterns on RecipeIngredientEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecipeIngredientEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecipeIngredientEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecipeIngredientEntity value)  $default,){
final _that = this;
switch (_that) {
case _RecipeIngredientEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecipeIngredientEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RecipeIngredientEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? quantity,  String? unit,  bool isSubstitute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecipeIngredientEntity() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.isSubstitute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? quantity,  String? unit,  bool isSubstitute)  $default,) {final _that = this;
switch (_that) {
case _RecipeIngredientEntity():
return $default(_that.name,_that.quantity,_that.unit,_that.isSubstitute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? quantity,  String? unit,  bool isSubstitute)?  $default,) {final _that = this;
switch (_that) {
case _RecipeIngredientEntity() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.isSubstitute);case _:
  return null;

}
}

}

/// @nodoc


class _RecipeIngredientEntity implements RecipeIngredientEntity {
   _RecipeIngredientEntity({this.name, this.quantity, this.unit, this.isSubstitute = false});
  

@override final  String? name;
@override final  String? quantity;
@override final  String? unit;
@override@JsonKey() final  bool isSubstitute;

/// Create a copy of RecipeIngredientEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecipeIngredientEntityCopyWith<_RecipeIngredientEntity> get copyWith => __$RecipeIngredientEntityCopyWithImpl<_RecipeIngredientEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecipeIngredientEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.isSubstitute, isSubstitute) || other.isSubstitute == isSubstitute));
}


@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,isSubstitute);

@override
String toString() {
  return 'RecipeIngredientEntity(name: $name, quantity: $quantity, unit: $unit, isSubstitute: $isSubstitute)';
}


}

/// @nodoc
abstract mixin class _$RecipeIngredientEntityCopyWith<$Res> implements $RecipeIngredientEntityCopyWith<$Res> {
  factory _$RecipeIngredientEntityCopyWith(_RecipeIngredientEntity value, $Res Function(_RecipeIngredientEntity) _then) = __$RecipeIngredientEntityCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? quantity, String? unit, bool isSubstitute
});




}
/// @nodoc
class __$RecipeIngredientEntityCopyWithImpl<$Res>
    implements _$RecipeIngredientEntityCopyWith<$Res> {
  __$RecipeIngredientEntityCopyWithImpl(this._self, this._then);

  final _RecipeIngredientEntity _self;
  final $Res Function(_RecipeIngredientEntity) _then;

/// Create a copy of RecipeIngredientEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? quantity = freezed,Object? unit = freezed,Object? isSubstitute = null,}) {
  return _then(_RecipeIngredientEntity(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,isSubstitute: null == isSubstitute ? _self.isSubstitute : isSubstitute // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
