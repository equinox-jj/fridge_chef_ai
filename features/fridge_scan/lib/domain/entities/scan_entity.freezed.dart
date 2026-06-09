// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanEntity {

 String? get id; String? get userId; String? get imageUrl; String? get rawAiResponse; DateTime? get scannedAt;
/// Create a copy of ScanEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanEntityCopyWith<ScanEntity> get copyWith => _$ScanEntityCopyWithImpl<ScanEntity>(this as ScanEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rawAiResponse, rawAiResponse) || other.rawAiResponse == rawAiResponse)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,imageUrl,rawAiResponse,scannedAt);

@override
String toString() {
  return 'ScanEntity(id: $id, userId: $userId, imageUrl: $imageUrl, rawAiResponse: $rawAiResponse, scannedAt: $scannedAt)';
}


}

/// @nodoc
abstract mixin class $ScanEntityCopyWith<$Res>  {
  factory $ScanEntityCopyWith(ScanEntity value, $Res Function(ScanEntity) _then) = _$ScanEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? userId, String? imageUrl, String? rawAiResponse, DateTime? scannedAt
});




}
/// @nodoc
class _$ScanEntityCopyWithImpl<$Res>
    implements $ScanEntityCopyWith<$Res> {
  _$ScanEntityCopyWithImpl(this._self, this._then);

  final ScanEntity _self;
  final $Res Function(ScanEntity) _then;

/// Create a copy of ScanEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? imageUrl = freezed,Object? rawAiResponse = freezed,Object? scannedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,rawAiResponse: freezed == rawAiResponse ? _self.rawAiResponse : rawAiResponse // ignore: cast_nullable_to_non_nullable
as String?,scannedAt: freezed == scannedAt ? _self.scannedAt : scannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanEntity].
extension ScanEntityPatterns on ScanEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanEntity value)  $default,){
final _that = this;
switch (_that) {
case _ScanEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ScanEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? imageUrl,  String? rawAiResponse,  DateTime? scannedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanEntity() when $default != null:
return $default(_that.id,_that.userId,_that.imageUrl,_that.rawAiResponse,_that.scannedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? imageUrl,  String? rawAiResponse,  DateTime? scannedAt)  $default,) {final _that = this;
switch (_that) {
case _ScanEntity():
return $default(_that.id,_that.userId,_that.imageUrl,_that.rawAiResponse,_that.scannedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? userId,  String? imageUrl,  String? rawAiResponse,  DateTime? scannedAt)?  $default,) {final _that = this;
switch (_that) {
case _ScanEntity() when $default != null:
return $default(_that.id,_that.userId,_that.imageUrl,_that.rawAiResponse,_that.scannedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ScanEntity implements ScanEntity {
   _ScanEntity({this.id, this.userId, this.imageUrl, this.rawAiResponse, this.scannedAt});
  

@override final  String? id;
@override final  String? userId;
@override final  String? imageUrl;
@override final  String? rawAiResponse;
@override final  DateTime? scannedAt;

/// Create a copy of ScanEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanEntityCopyWith<_ScanEntity> get copyWith => __$ScanEntityCopyWithImpl<_ScanEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rawAiResponse, rawAiResponse) || other.rawAiResponse == rawAiResponse)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,imageUrl,rawAiResponse,scannedAt);

@override
String toString() {
  return 'ScanEntity(id: $id, userId: $userId, imageUrl: $imageUrl, rawAiResponse: $rawAiResponse, scannedAt: $scannedAt)';
}


}

/// @nodoc
abstract mixin class _$ScanEntityCopyWith<$Res> implements $ScanEntityCopyWith<$Res> {
  factory _$ScanEntityCopyWith(_ScanEntity value, $Res Function(_ScanEntity) _then) = __$ScanEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? userId, String? imageUrl, String? rawAiResponse, DateTime? scannedAt
});




}
/// @nodoc
class __$ScanEntityCopyWithImpl<$Res>
    implements _$ScanEntityCopyWith<$Res> {
  __$ScanEntityCopyWithImpl(this._self, this._then);

  final _ScanEntity _self;
  final $Res Function(_ScanEntity) _then;

/// Create a copy of ScanEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? imageUrl = freezed,Object? rawAiResponse = freezed,Object? scannedAt = freezed,}) {
  return _then(_ScanEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,rawAiResponse: freezed == rawAiResponse ? _self.rawAiResponse : rawAiResponse // ignore: cast_nullable_to_non_nullable
as String?,scannedAt: freezed == scannedAt ? _self.scannedAt : scannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
