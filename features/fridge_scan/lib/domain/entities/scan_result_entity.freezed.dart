// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanResultEntity {

 ScanEntity get scan; List<IngredientEntity> get ingredients;
/// Create a copy of ScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanResultEntityCopyWith<ScanResultEntity> get copyWith => _$ScanResultEntityCopyWithImpl<ScanResultEntity>(this as ScanResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanResultEntity&&(identical(other.scan, scan) || other.scan == scan)&&const DeepCollectionEquality().equals(other.ingredients, ingredients));
}


@override
int get hashCode => Object.hash(runtimeType,scan,const DeepCollectionEquality().hash(ingredients));

@override
String toString() {
  return 'ScanResultEntity(scan: $scan, ingredients: $ingredients)';
}


}

/// @nodoc
abstract mixin class $ScanResultEntityCopyWith<$Res>  {
  factory $ScanResultEntityCopyWith(ScanResultEntity value, $Res Function(ScanResultEntity) _then) = _$ScanResultEntityCopyWithImpl;
@useResult
$Res call({
 ScanEntity scan, List<IngredientEntity> ingredients
});


$ScanEntityCopyWith<$Res> get scan;

}
/// @nodoc
class _$ScanResultEntityCopyWithImpl<$Res>
    implements $ScanResultEntityCopyWith<$Res> {
  _$ScanResultEntityCopyWithImpl(this._self, this._then);

  final ScanResultEntity _self;
  final $Res Function(ScanResultEntity) _then;

/// Create a copy of ScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scan = null,Object? ingredients = null,}) {
  return _then(_self.copyWith(
scan: null == scan ? _self.scan : scan // ignore: cast_nullable_to_non_nullable
as ScanEntity,ingredients: null == ingredients ? _self.ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<IngredientEntity>,
  ));
}
/// Create a copy of ScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanEntityCopyWith<$Res> get scan {
  
  return $ScanEntityCopyWith<$Res>(_self.scan, (value) {
    return _then(_self.copyWith(scan: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScanResultEntity].
extension ScanResultEntityPatterns on ScanResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _ScanResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ScanResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScanEntity scan,  List<IngredientEntity> ingredients)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanResultEntity() when $default != null:
return $default(_that.scan,_that.ingredients);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScanEntity scan,  List<IngredientEntity> ingredients)  $default,) {final _that = this;
switch (_that) {
case _ScanResultEntity():
return $default(_that.scan,_that.ingredients);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScanEntity scan,  List<IngredientEntity> ingredients)?  $default,) {final _that = this;
switch (_that) {
case _ScanResultEntity() when $default != null:
return $default(_that.scan,_that.ingredients);case _:
  return null;

}
}

}

/// @nodoc


class _ScanResultEntity implements ScanResultEntity {
   _ScanResultEntity({required this.scan, required final  List<IngredientEntity> ingredients}): _ingredients = ingredients;
  

@override final  ScanEntity scan;
 final  List<IngredientEntity> _ingredients;
@override List<IngredientEntity> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}


/// Create a copy of ScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanResultEntityCopyWith<_ScanResultEntity> get copyWith => __$ScanResultEntityCopyWithImpl<_ScanResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanResultEntity&&(identical(other.scan, scan) || other.scan == scan)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients));
}


@override
int get hashCode => Object.hash(runtimeType,scan,const DeepCollectionEquality().hash(_ingredients));

@override
String toString() {
  return 'ScanResultEntity(scan: $scan, ingredients: $ingredients)';
}


}

/// @nodoc
abstract mixin class _$ScanResultEntityCopyWith<$Res> implements $ScanResultEntityCopyWith<$Res> {
  factory _$ScanResultEntityCopyWith(_ScanResultEntity value, $Res Function(_ScanResultEntity) _then) = __$ScanResultEntityCopyWithImpl;
@override @useResult
$Res call({
 ScanEntity scan, List<IngredientEntity> ingredients
});


@override $ScanEntityCopyWith<$Res> get scan;

}
/// @nodoc
class __$ScanResultEntityCopyWithImpl<$Res>
    implements _$ScanResultEntityCopyWith<$Res> {
  __$ScanResultEntityCopyWithImpl(this._self, this._then);

  final _ScanResultEntity _self;
  final $Res Function(_ScanResultEntity) _then;

/// Create a copy of ScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scan = null,Object? ingredients = null,}) {
  return _then(_ScanResultEntity(
scan: null == scan ? _self.scan : scan // ignore: cast_nullable_to_non_nullable
as ScanEntity,ingredients: null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<IngredientEntity>,
  ));
}

/// Create a copy of ScanResultEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanEntityCopyWith<$Res> get scan {
  
  return $ScanEntityCopyWith<$Res>(_self.scan, (value) {
    return _then(_self.copyWith(scan: value));
  });
}
}

// dart format on
