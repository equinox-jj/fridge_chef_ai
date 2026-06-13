// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_history_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanHistoryState {

 List<ScanResultEntity> get scans; BlocStatus get status;
/// Create a copy of ScanHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanHistoryStateCopyWith<ScanHistoryState> get copyWith => _$ScanHistoryStateCopyWithImpl<ScanHistoryState>(this as ScanHistoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanHistoryState&&const DeepCollectionEquality().equals(other.scans, scans)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(scans),status);

@override
String toString() {
  return 'ScanHistoryState(scans: $scans, status: $status)';
}


}

/// @nodoc
abstract mixin class $ScanHistoryStateCopyWith<$Res>  {
  factory $ScanHistoryStateCopyWith(ScanHistoryState value, $Res Function(ScanHistoryState) _then) = _$ScanHistoryStateCopyWithImpl;
@useResult
$Res call({
 List<ScanResultEntity> scans, BlocStatus status
});




}
/// @nodoc
class _$ScanHistoryStateCopyWithImpl<$Res>
    implements $ScanHistoryStateCopyWith<$Res> {
  _$ScanHistoryStateCopyWithImpl(this._self, this._then);

  final ScanHistoryState _self;
  final $Res Function(ScanHistoryState) _then;

/// Create a copy of ScanHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scans = null,Object? status = null,}) {
  return _then(_self.copyWith(
scans: null == scans ? _self.scans : scans // ignore: cast_nullable_to_non_nullable
as List<ScanResultEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanHistoryState].
extension ScanHistoryStatePatterns on ScanHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanHistoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanHistoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanHistoryState value)  $default,){
final _that = this;
switch (_that) {
case _ScanHistoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanHistoryState value)?  $default,){
final _that = this;
switch (_that) {
case _ScanHistoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ScanResultEntity> scans,  BlocStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanHistoryState() when $default != null:
return $default(_that.scans,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ScanResultEntity> scans,  BlocStatus status)  $default,) {final _that = this;
switch (_that) {
case _ScanHistoryState():
return $default(_that.scans,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ScanResultEntity> scans,  BlocStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ScanHistoryState() when $default != null:
return $default(_that.scans,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ScanHistoryState implements ScanHistoryState {
  const _ScanHistoryState({final  List<ScanResultEntity> scans = const <ScanResultEntity>[], this.status = BlocStatus.initial}): _scans = scans;
  

 final  List<ScanResultEntity> _scans;
@override@JsonKey() List<ScanResultEntity> get scans {
  if (_scans is EqualUnmodifiableListView) return _scans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scans);
}

@override@JsonKey() final  BlocStatus status;

/// Create a copy of ScanHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanHistoryStateCopyWith<_ScanHistoryState> get copyWith => __$ScanHistoryStateCopyWithImpl<_ScanHistoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanHistoryState&&const DeepCollectionEquality().equals(other._scans, _scans)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_scans),status);

@override
String toString() {
  return 'ScanHistoryState(scans: $scans, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ScanHistoryStateCopyWith<$Res> implements $ScanHistoryStateCopyWith<$Res> {
  factory _$ScanHistoryStateCopyWith(_ScanHistoryState value, $Res Function(_ScanHistoryState) _then) = __$ScanHistoryStateCopyWithImpl;
@override @useResult
$Res call({
 List<ScanResultEntity> scans, BlocStatus status
});




}
/// @nodoc
class __$ScanHistoryStateCopyWithImpl<$Res>
    implements _$ScanHistoryStateCopyWith<$Res> {
  __$ScanHistoryStateCopyWithImpl(this._self, this._then);

  final _ScanHistoryState _self;
  final $Res Function(_ScanHistoryState) _then;

/// Create a copy of ScanHistoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scans = null,Object? status = null,}) {
  return _then(_ScanHistoryState(
scans: null == scans ? _self._scans : scans // ignore: cast_nullable_to_non_nullable
as List<ScanResultEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,
  ));
}


}

// dart format on
