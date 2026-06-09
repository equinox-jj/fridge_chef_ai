// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScanModel {

@JsonKey(name: 'id') String? get id;@JsonKey(name: 'user_id') String? get userId;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'raw_ai_response') String? get rawAiResponse;@JsonKey(name: 'scanned_at') DateTime? get scannedAt;
/// Create a copy of ScanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanModelCopyWith<ScanModel> get copyWith => _$ScanModelCopyWithImpl<ScanModel>(this as ScanModel, _$identity);

  /// Serializes this ScanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rawAiResponse, rawAiResponse) || other.rawAiResponse == rawAiResponse)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,imageUrl,rawAiResponse,scannedAt);

@override
String toString() {
  return 'ScanModel(id: $id, userId: $userId, imageUrl: $imageUrl, rawAiResponse: $rawAiResponse, scannedAt: $scannedAt)';
}


}

/// @nodoc
abstract mixin class $ScanModelCopyWith<$Res>  {
  factory $ScanModelCopyWith(ScanModel value, $Res Function(ScanModel) _then) = _$ScanModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'raw_ai_response') String? rawAiResponse,@JsonKey(name: 'scanned_at') DateTime? scannedAt
});




}
/// @nodoc
class _$ScanModelCopyWithImpl<$Res>
    implements $ScanModelCopyWith<$Res> {
  _$ScanModelCopyWithImpl(this._self, this._then);

  final ScanModel _self;
  final $Res Function(ScanModel) _then;

/// Create a copy of ScanModel
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


/// Adds pattern-matching-related methods to [ScanModel].
extension ScanModelPatterns on ScanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanModel value)  $default,){
final _that = this;
switch (_that) {
case _ScanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'raw_ai_response')  String? rawAiResponse, @JsonKey(name: 'scanned_at')  DateTime? scannedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'raw_ai_response')  String? rawAiResponse, @JsonKey(name: 'scanned_at')  DateTime? scannedAt)  $default,) {final _that = this;
switch (_that) {
case _ScanModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  String? id, @JsonKey(name: 'user_id')  String? userId, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'raw_ai_response')  String? rawAiResponse, @JsonKey(name: 'scanned_at')  DateTime? scannedAt)?  $default,) {final _that = this;
switch (_that) {
case _ScanModel() when $default != null:
return $default(_that.id,_that.userId,_that.imageUrl,_that.rawAiResponse,_that.scannedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanModel implements ScanModel {
   _ScanModel({@JsonKey(name: 'id') this.id, @JsonKey(name: 'user_id') this.userId, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'raw_ai_response') this.rawAiResponse, @JsonKey(name: 'scanned_at') this.scannedAt});
  factory _ScanModel.fromJson(Map<String, dynamic> json) => _$ScanModelFromJson(json);

@override@JsonKey(name: 'id') final  String? id;
@override@JsonKey(name: 'user_id') final  String? userId;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'raw_ai_response') final  String? rawAiResponse;
@override@JsonKey(name: 'scanned_at') final  DateTime? scannedAt;

/// Create a copy of ScanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanModelCopyWith<_ScanModel> get copyWith => __$ScanModelCopyWithImpl<_ScanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rawAiResponse, rawAiResponse) || other.rawAiResponse == rawAiResponse)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,imageUrl,rawAiResponse,scannedAt);

@override
String toString() {
  return 'ScanModel(id: $id, userId: $userId, imageUrl: $imageUrl, rawAiResponse: $rawAiResponse, scannedAt: $scannedAt)';
}


}

/// @nodoc
abstract mixin class _$ScanModelCopyWith<$Res> implements $ScanModelCopyWith<$Res> {
  factory _$ScanModelCopyWith(_ScanModel value, $Res Function(_ScanModel) _then) = __$ScanModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String? id,@JsonKey(name: 'user_id') String? userId,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'raw_ai_response') String? rawAiResponse,@JsonKey(name: 'scanned_at') DateTime? scannedAt
});




}
/// @nodoc
class __$ScanModelCopyWithImpl<$Res>
    implements _$ScanModelCopyWith<$Res> {
  __$ScanModelCopyWithImpl(this._self, this._then);

  final _ScanModel _self;
  final $Res Function(_ScanModel) _then;

/// Create a copy of ScanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? imageUrl = freezed,Object? rawAiResponse = freezed,Object? scannedAt = freezed,}) {
  return _then(_ScanModel(
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
