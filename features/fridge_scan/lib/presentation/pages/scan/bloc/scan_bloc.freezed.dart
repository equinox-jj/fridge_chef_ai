// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScanEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanEvent()';
}


}

/// @nodoc
class $ScanEventCopyWith<$Res>  {
$ScanEventCopyWith(ScanEvent _, $Res Function(ScanEvent) __);
}


/// Adds pattern-matching-related methods to [ScanEvent].
extension ScanEventPatterns on ScanEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SourceSelected value)?  sourceSelected,TResult Function( _ScanConfirmed value)?  confirmed,TResult Function( _ScanRetaken value)?  retaken,TResult Function( _SettingsRequested value)?  settingsRequested,TResult Function( _ScanReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SourceSelected() when sourceSelected != null:
return sourceSelected(_that);case _ScanConfirmed() when confirmed != null:
return confirmed(_that);case _ScanRetaken() when retaken != null:
return retaken(_that);case _SettingsRequested() when settingsRequested != null:
return settingsRequested(_that);case _ScanReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SourceSelected value)  sourceSelected,required TResult Function( _ScanConfirmed value)  confirmed,required TResult Function( _ScanRetaken value)  retaken,required TResult Function( _SettingsRequested value)  settingsRequested,required TResult Function( _ScanReset value)  reset,}){
final _that = this;
switch (_that) {
case _SourceSelected():
return sourceSelected(_that);case _ScanConfirmed():
return confirmed(_that);case _ScanRetaken():
return retaken(_that);case _SettingsRequested():
return settingsRequested(_that);case _ScanReset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SourceSelected value)?  sourceSelected,TResult? Function( _ScanConfirmed value)?  confirmed,TResult? Function( _ScanRetaken value)?  retaken,TResult? Function( _SettingsRequested value)?  settingsRequested,TResult? Function( _ScanReset value)?  reset,}){
final _that = this;
switch (_that) {
case _SourceSelected() when sourceSelected != null:
return sourceSelected(_that);case _ScanConfirmed() when confirmed != null:
return confirmed(_that);case _ScanRetaken() when retaken != null:
return retaken(_that);case _SettingsRequested() when settingsRequested != null:
return settingsRequested(_that);case _ScanReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ImageSourceOption source)?  sourceSelected,TResult Function()?  confirmed,TResult Function()?  retaken,TResult Function()?  settingsRequested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SourceSelected() when sourceSelected != null:
return sourceSelected(_that.source);case _ScanConfirmed() when confirmed != null:
return confirmed();case _ScanRetaken() when retaken != null:
return retaken();case _SettingsRequested() when settingsRequested != null:
return settingsRequested();case _ScanReset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ImageSourceOption source)  sourceSelected,required TResult Function()  confirmed,required TResult Function()  retaken,required TResult Function()  settingsRequested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _SourceSelected():
return sourceSelected(_that.source);case _ScanConfirmed():
return confirmed();case _ScanRetaken():
return retaken();case _SettingsRequested():
return settingsRequested();case _ScanReset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ImageSourceOption source)?  sourceSelected,TResult? Function()?  confirmed,TResult? Function()?  retaken,TResult? Function()?  settingsRequested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _SourceSelected() when sourceSelected != null:
return sourceSelected(_that.source);case _ScanConfirmed() when confirmed != null:
return confirmed();case _ScanRetaken() when retaken != null:
return retaken();case _SettingsRequested() when settingsRequested != null:
return settingsRequested();case _ScanReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _SourceSelected implements ScanEvent {
  const _SourceSelected(this.source);
  

 final  ImageSourceOption source;

/// Create a copy of ScanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceSelectedCopyWith<_SourceSelected> get copyWith => __$SourceSelectedCopyWithImpl<_SourceSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceSelected&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'ScanEvent.sourceSelected(source: $source)';
}


}

/// @nodoc
abstract mixin class _$SourceSelectedCopyWith<$Res> implements $ScanEventCopyWith<$Res> {
  factory _$SourceSelectedCopyWith(_SourceSelected value, $Res Function(_SourceSelected) _then) = __$SourceSelectedCopyWithImpl;
@useResult
$Res call({
 ImageSourceOption source
});




}
/// @nodoc
class __$SourceSelectedCopyWithImpl<$Res>
    implements _$SourceSelectedCopyWith<$Res> {
  __$SourceSelectedCopyWithImpl(this._self, this._then);

  final _SourceSelected _self;
  final $Res Function(_SourceSelected) _then;

/// Create a copy of ScanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(_SourceSelected(
null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ImageSourceOption,
  ));
}


}

/// @nodoc


class _ScanConfirmed implements ScanEvent {
  const _ScanConfirmed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanConfirmed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanEvent.confirmed()';
}


}




/// @nodoc


class _ScanRetaken implements ScanEvent {
  const _ScanRetaken();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanRetaken);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanEvent.retaken()';
}


}




/// @nodoc


class _SettingsRequested implements ScanEvent {
  const _SettingsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanEvent.settingsRequested()';
}


}




/// @nodoc


class _ScanReset implements ScanEvent {
  const _ScanReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanEvent.reset()';
}


}




/// @nodoc
mixin _$ScanState {

/// Stage of the capture/preview flow.
 ScanPickStatus get pickStatus;/// The photo awaiting confirmation, once one has been captured.
 XFile? get pickedImage;/// Outcome of the last permission request, set when it was not granted.
 PermissionResult? get permission;/// Lifecycle of the AI scan triggered on confirmation.
 BlocStatus get scanState; Failure? get scanFailure; ScanEntity? get scanResponse; List<IngredientEntity>? get ingredientsResponse;
/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanStateCopyWith<ScanState> get copyWith => _$ScanStateCopyWithImpl<ScanState>(this as ScanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanState&&(identical(other.pickStatus, pickStatus) || other.pickStatus == pickStatus)&&(identical(other.pickedImage, pickedImage) || other.pickedImage == pickedImage)&&(identical(other.permission, permission) || other.permission == permission)&&(identical(other.scanState, scanState) || other.scanState == scanState)&&(identical(other.scanFailure, scanFailure) || other.scanFailure == scanFailure)&&(identical(other.scanResponse, scanResponse) || other.scanResponse == scanResponse)&&const DeepCollectionEquality().equals(other.ingredientsResponse, ingredientsResponse));
}


@override
int get hashCode => Object.hash(runtimeType,pickStatus,pickedImage,permission,scanState,scanFailure,scanResponse,const DeepCollectionEquality().hash(ingredientsResponse));

@override
String toString() {
  return 'ScanState(pickStatus: $pickStatus, pickedImage: $pickedImage, permission: $permission, scanState: $scanState, scanFailure: $scanFailure, scanResponse: $scanResponse, ingredientsResponse: $ingredientsResponse)';
}


}

/// @nodoc
abstract mixin class $ScanStateCopyWith<$Res>  {
  factory $ScanStateCopyWith(ScanState value, $Res Function(ScanState) _then) = _$ScanStateCopyWithImpl;
@useResult
$Res call({
 ScanPickStatus pickStatus, XFile? pickedImage, PermissionResult? permission, BlocStatus scanState, Failure? scanFailure, ScanEntity? scanResponse, List<IngredientEntity>? ingredientsResponse
});


$ScanEntityCopyWith<$Res>? get scanResponse;

}
/// @nodoc
class _$ScanStateCopyWithImpl<$Res>
    implements $ScanStateCopyWith<$Res> {
  _$ScanStateCopyWithImpl(this._self, this._then);

  final ScanState _self;
  final $Res Function(ScanState) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pickStatus = null,Object? pickedImage = freezed,Object? permission = freezed,Object? scanState = null,Object? scanFailure = freezed,Object? scanResponse = freezed,Object? ingredientsResponse = freezed,}) {
  return _then(_self.copyWith(
pickStatus: null == pickStatus ? _self.pickStatus : pickStatus // ignore: cast_nullable_to_non_nullable
as ScanPickStatus,pickedImage: freezed == pickedImage ? _self.pickedImage : pickedImage // ignore: cast_nullable_to_non_nullable
as XFile?,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as PermissionResult?,scanState: null == scanState ? _self.scanState : scanState // ignore: cast_nullable_to_non_nullable
as BlocStatus,scanFailure: freezed == scanFailure ? _self.scanFailure : scanFailure // ignore: cast_nullable_to_non_nullable
as Failure?,scanResponse: freezed == scanResponse ? _self.scanResponse : scanResponse // ignore: cast_nullable_to_non_nullable
as ScanEntity?,ingredientsResponse: freezed == ingredientsResponse ? _self.ingredientsResponse : ingredientsResponse // ignore: cast_nullable_to_non_nullable
as List<IngredientEntity>?,
  ));
}
/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanEntityCopyWith<$Res>? get scanResponse {
    if (_self.scanResponse == null) {
    return null;
  }

  return $ScanEntityCopyWith<$Res>(_self.scanResponse!, (value) {
    return _then(_self.copyWith(scanResponse: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScanState].
extension ScanStatePatterns on ScanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( ScanInitial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScanInitial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( ScanInitial value)  $default,){
final _that = this;
switch (_that) {
case ScanInitial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( ScanInitial value)?  $default,){
final _that = this;
switch (_that) {
case ScanInitial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScanPickStatus pickStatus,  XFile? pickedImage,  PermissionResult? permission,  BlocStatus scanState,  Failure? scanFailure,  ScanEntity? scanResponse,  List<IngredientEntity>? ingredientsResponse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScanInitial() when $default != null:
return $default(_that.pickStatus,_that.pickedImage,_that.permission,_that.scanState,_that.scanFailure,_that.scanResponse,_that.ingredientsResponse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScanPickStatus pickStatus,  XFile? pickedImage,  PermissionResult? permission,  BlocStatus scanState,  Failure? scanFailure,  ScanEntity? scanResponse,  List<IngredientEntity>? ingredientsResponse)  $default,) {final _that = this;
switch (_that) {
case ScanInitial():
return $default(_that.pickStatus,_that.pickedImage,_that.permission,_that.scanState,_that.scanFailure,_that.scanResponse,_that.ingredientsResponse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScanPickStatus pickStatus,  XFile? pickedImage,  PermissionResult? permission,  BlocStatus scanState,  Failure? scanFailure,  ScanEntity? scanResponse,  List<IngredientEntity>? ingredientsResponse)?  $default,) {final _that = this;
switch (_that) {
case ScanInitial() when $default != null:
return $default(_that.pickStatus,_that.pickedImage,_that.permission,_that.scanState,_that.scanFailure,_that.scanResponse,_that.ingredientsResponse);case _:
  return null;

}
}

}

/// @nodoc


class ScanInitial implements ScanState {
  const ScanInitial({this.pickStatus = ScanPickStatus.idle, this.pickedImage, this.permission, this.scanState = BlocStatus.initial, this.scanFailure, this.scanResponse, final  List<IngredientEntity>? ingredientsResponse}): _ingredientsResponse = ingredientsResponse;
  

/// Stage of the capture/preview flow.
@override@JsonKey() final  ScanPickStatus pickStatus;
/// The photo awaiting confirmation, once one has been captured.
@override final  XFile? pickedImage;
/// Outcome of the last permission request, set when it was not granted.
@override final  PermissionResult? permission;
/// Lifecycle of the AI scan triggered on confirmation.
@override@JsonKey() final  BlocStatus scanState;
@override final  Failure? scanFailure;
@override final  ScanEntity? scanResponse;
 final  List<IngredientEntity>? _ingredientsResponse;
@override List<IngredientEntity>? get ingredientsResponse {
  final value = _ingredientsResponse;
  if (value == null) return null;
  if (_ingredientsResponse is EqualUnmodifiableListView) return _ingredientsResponse;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanInitialCopyWith<ScanInitial> get copyWith => _$ScanInitialCopyWithImpl<ScanInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanInitial&&(identical(other.pickStatus, pickStatus) || other.pickStatus == pickStatus)&&(identical(other.pickedImage, pickedImage) || other.pickedImage == pickedImage)&&(identical(other.permission, permission) || other.permission == permission)&&(identical(other.scanState, scanState) || other.scanState == scanState)&&(identical(other.scanFailure, scanFailure) || other.scanFailure == scanFailure)&&(identical(other.scanResponse, scanResponse) || other.scanResponse == scanResponse)&&const DeepCollectionEquality().equals(other._ingredientsResponse, _ingredientsResponse));
}


@override
int get hashCode => Object.hash(runtimeType,pickStatus,pickedImage,permission,scanState,scanFailure,scanResponse,const DeepCollectionEquality().hash(_ingredientsResponse));

@override
String toString() {
  return 'ScanState(pickStatus: $pickStatus, pickedImage: $pickedImage, permission: $permission, scanState: $scanState, scanFailure: $scanFailure, scanResponse: $scanResponse, ingredientsResponse: $ingredientsResponse)';
}


}

/// @nodoc
abstract mixin class $ScanInitialCopyWith<$Res> implements $ScanStateCopyWith<$Res> {
  factory $ScanInitialCopyWith(ScanInitial value, $Res Function(ScanInitial) _then) = _$ScanInitialCopyWithImpl;
@override @useResult
$Res call({
 ScanPickStatus pickStatus, XFile? pickedImage, PermissionResult? permission, BlocStatus scanState, Failure? scanFailure, ScanEntity? scanResponse, List<IngredientEntity>? ingredientsResponse
});


@override $ScanEntityCopyWith<$Res>? get scanResponse;

}
/// @nodoc
class _$ScanInitialCopyWithImpl<$Res>
    implements $ScanInitialCopyWith<$Res> {
  _$ScanInitialCopyWithImpl(this._self, this._then);

  final ScanInitial _self;
  final $Res Function(ScanInitial) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pickStatus = null,Object? pickedImage = freezed,Object? permission = freezed,Object? scanState = null,Object? scanFailure = freezed,Object? scanResponse = freezed,Object? ingredientsResponse = freezed,}) {
  return _then(ScanInitial(
pickStatus: null == pickStatus ? _self.pickStatus : pickStatus // ignore: cast_nullable_to_non_nullable
as ScanPickStatus,pickedImage: freezed == pickedImage ? _self.pickedImage : pickedImage // ignore: cast_nullable_to_non_nullable
as XFile?,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as PermissionResult?,scanState: null == scanState ? _self.scanState : scanState // ignore: cast_nullable_to_non_nullable
as BlocStatus,scanFailure: freezed == scanFailure ? _self.scanFailure : scanFailure // ignore: cast_nullable_to_non_nullable
as Failure?,scanResponse: freezed == scanResponse ? _self.scanResponse : scanResponse // ignore: cast_nullable_to_non_nullable
as ScanEntity?,ingredientsResponse: freezed == ingredientsResponse ? _self._ingredientsResponse : ingredientsResponse // ignore: cast_nullable_to_non_nullable
as List<IngredientEntity>?,
  ));
}

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanEntityCopyWith<$Res>? get scanResponse {
    if (_self.scanResponse == null) {
    return null;
  }

  return $ScanEntityCopyWith<$Res>(_self.scanResponse!, (value) {
    return _then(_self.copyWith(scanResponse: value));
  });
}
}

// dart format on
