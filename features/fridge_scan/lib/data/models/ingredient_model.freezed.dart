// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ingredient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IngredientModel {

@JsonKey(name: 'id') String? get id;@JsonKey(name: 'scan_id') String? get scanId;@JsonKey(name: 'name') String? get name;@JsonKey(name: 'quantity') String? get quantity;@JsonKey(name: 'unit') String? get unit;@JsonKey(name: 'category') String? get category;
/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IngredientModelCopyWith<IngredientModel> get copyWith => _$IngredientModelCopyWithImpl<IngredientModel>(this as IngredientModel, _$identity);

  /// Serializes this IngredientModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IngredientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.scanId, scanId) || other.scanId == scanId)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scanId,name,quantity,unit,category);

@override
String toString() {
  return 'IngredientModel(id: $id, scanId: $scanId, name: $name, quantity: $quantity, unit: $unit, category: $category)';
}


}

/// @nodoc
abstract mixin class $IngredientModelCopyWith<$Res>  {
  factory $IngredientModelCopyWith(IngredientModel value, $Res Function(IngredientModel) _then) = _$IngredientModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'scan_id') String? scanId,@JsonKey(name: 'name') String? name,@JsonKey(name: 'quantity') String? quantity,@JsonKey(name: 'unit') String? unit,@JsonKey(name: 'category') String? category
});




}
/// @nodoc
class _$IngredientModelCopyWithImpl<$Res>
    implements $IngredientModelCopyWith<$Res> {
  _$IngredientModelCopyWithImpl(this._self, this._then);

  final IngredientModel _self;
  final $Res Function(IngredientModel) _then;

/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? scanId = freezed,Object? name = freezed,Object? quantity = freezed,Object? unit = freezed,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,scanId: freezed == scanId ? _self.scanId : scanId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IngredientModel].
extension IngredientModelPatterns on IngredientModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IngredientModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IngredientModel value)  $default,){
final _that = this;
switch (_that) {
case _IngredientModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IngredientModel value)?  $default,){
final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'scan_id')  String? scanId, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'quantity')  String? quantity, @JsonKey(name: 'unit')  String? unit, @JsonKey(name: 'category')  String? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
return $default(_that.id,_that.scanId,_that.name,_that.quantity,_that.unit,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'scan_id')  String? scanId, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'quantity')  String? quantity, @JsonKey(name: 'unit')  String? unit, @JsonKey(name: 'category')  String? category)  $default,) {final _that = this;
switch (_that) {
case _IngredientModel():
return $default(_that.id,_that.scanId,_that.name,_that.quantity,_that.unit,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'scan_id')  String? scanId, @JsonKey(name: 'name')  String? name, @JsonKey(name: 'quantity')  String? quantity, @JsonKey(name: 'unit')  String? unit, @JsonKey(name: 'category')  String? category)?  $default,) {final _that = this;
switch (_that) {
case _IngredientModel() when $default != null:
return $default(_that.id,_that.scanId,_that.name,_that.quantity,_that.unit,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IngredientModel implements IngredientModel {
   _IngredientModel({@JsonKey(name: 'id') this.id, @JsonKey(name: 'scan_id') this.scanId, @JsonKey(name: 'name') this.name, @JsonKey(name: 'quantity') this.quantity, @JsonKey(name: 'unit') this.unit, @JsonKey(name: 'category') this.category});
  factory _IngredientModel.fromJson(Map<String, dynamic> json) => _$IngredientModelFromJson(json);

@override@JsonKey(name: 'id') final  String? id;
@override@JsonKey(name: 'scan_id') final  String? scanId;
@override@JsonKey(name: 'name') final  String? name;
@override@JsonKey(name: 'quantity') final  String? quantity;
@override@JsonKey(name: 'unit') final  String? unit;
@override@JsonKey(name: 'category') final  String? category;

/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IngredientModelCopyWith<_IngredientModel> get copyWith => __$IngredientModelCopyWithImpl<_IngredientModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IngredientModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IngredientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.scanId, scanId) || other.scanId == scanId)&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scanId,name,quantity,unit,category);

@override
String toString() {
  return 'IngredientModel(id: $id, scanId: $scanId, name: $name, quantity: $quantity, unit: $unit, category: $category)';
}


}

/// @nodoc
abstract mixin class _$IngredientModelCopyWith<$Res> implements $IngredientModelCopyWith<$Res> {
  factory _$IngredientModelCopyWith(_IngredientModel value, $Res Function(_IngredientModel) _then) = __$IngredientModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'scan_id') String? scanId,@JsonKey(name: 'name') String? name,@JsonKey(name: 'quantity') String? quantity,@JsonKey(name: 'unit') String? unit,@JsonKey(name: 'category') String? category
});




}
/// @nodoc
class __$IngredientModelCopyWithImpl<$Res>
    implements _$IngredientModelCopyWith<$Res> {
  __$IngredientModelCopyWithImpl(this._self, this._then);

  final _IngredientModel _self;
  final $Res Function(_IngredientModel) _then;

/// Create a copy of IngredientModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? scanId = freezed,Object? name = freezed,Object? quantity = freezed,Object? unit = freezed,Object? category = freezed,}) {
  return _then(_IngredientModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,scanId: freezed == scanId ? _self.scanId : scanId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as String?,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
