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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ScanConfirmed value)?  confirmed,TResult Function( _ScanReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanConfirmed() when confirmed != null:
return confirmed(_that);case _ScanReset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ScanConfirmed value)  confirmed,required TResult Function( _ScanReset value)  reset,}){
final _that = this;
switch (_that) {
case _ScanConfirmed():
return confirmed(_that);case _ScanReset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ScanConfirmed value)?  confirmed,TResult? Function( _ScanReset value)?  reset,}){
final _that = this;
switch (_that) {
case _ScanConfirmed() when confirmed != null:
return confirmed(_that);case _ScanReset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( XFile file)?  confirmed,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanConfirmed() when confirmed != null:
return confirmed(_that.file);case _ScanReset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( XFile file)  confirmed,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _ScanConfirmed():
return confirmed(_that.file);case _ScanReset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( XFile file)?  confirmed,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _ScanConfirmed() when confirmed != null:
return confirmed(_that.file);case _ScanReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _ScanConfirmed implements ScanEvent {
  const _ScanConfirmed(this.file);
  

 final  XFile file;

/// Create a copy of ScanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanConfirmedCopyWith<_ScanConfirmed> get copyWith => __$ScanConfirmedCopyWithImpl<_ScanConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanConfirmed&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'ScanEvent.confirmed(file: $file)';
}


}

/// @nodoc
abstract mixin class _$ScanConfirmedCopyWith<$Res> implements $ScanEventCopyWith<$Res> {
  factory _$ScanConfirmedCopyWith(_ScanConfirmed value, $Res Function(_ScanConfirmed) _then) = __$ScanConfirmedCopyWithImpl;
@useResult
$Res call({
 XFile file
});




}
/// @nodoc
class __$ScanConfirmedCopyWithImpl<$Res>
    implements _$ScanConfirmedCopyWith<$Res> {
  __$ScanConfirmedCopyWithImpl(this._self, this._then);

  final _ScanConfirmed _self;
  final $Res Function(_ScanConfirmed) _then;

/// Create a copy of ScanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(_ScanConfirmed(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as XFile,
  ));
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

 BlocStatus get scanState; Failure? get scanFailure; ScanEntity? get scanResponse; List<IngredientEntity>? get ingredientsResponse;
/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanStateCopyWith<ScanState> get copyWith => _$ScanStateCopyWithImpl<ScanState>(this as ScanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanState&&(identical(other.scanState, scanState) || other.scanState == scanState)&&(identical(other.scanFailure, scanFailure) || other.scanFailure == scanFailure)&&(identical(other.scanResponse, scanResponse) || other.scanResponse == scanResponse)&&const DeepCollectionEquality().equals(other.ingredientsResponse, ingredientsResponse));
}


@override
int get hashCode => Object.hash(runtimeType,scanState,scanFailure,scanResponse,const DeepCollectionEquality().hash(ingredientsResponse));

@override
String toString() {
  return 'ScanState(scanState: $scanState, scanFailure: $scanFailure, scanResponse: $scanResponse, ingredientsResponse: $ingredientsResponse)';
}


}

/// @nodoc
abstract mixin class $ScanStateCopyWith<$Res>  {
  factory $ScanStateCopyWith(ScanState value, $Res Function(ScanState) _then) = _$ScanStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus scanState, Failure? scanFailure, ScanEntity? scanResponse, List<IngredientEntity>? ingredientsResponse
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
@pragma('vm:prefer-inline') @override $Res call({Object? scanState = null,Object? scanFailure = freezed,Object? scanResponse = freezed,Object? ingredientsResponse = freezed,}) {
  return _then(_self.copyWith(
scanState: null == scanState ? _self.scanState : scanState // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus scanState,  Failure? scanFailure,  ScanEntity? scanResponse,  List<IngredientEntity>? ingredientsResponse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScanInitial() when $default != null:
return $default(_that.scanState,_that.scanFailure,_that.scanResponse,_that.ingredientsResponse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus scanState,  Failure? scanFailure,  ScanEntity? scanResponse,  List<IngredientEntity>? ingredientsResponse)  $default,) {final _that = this;
switch (_that) {
case ScanInitial():
return $default(_that.scanState,_that.scanFailure,_that.scanResponse,_that.ingredientsResponse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus scanState,  Failure? scanFailure,  ScanEntity? scanResponse,  List<IngredientEntity>? ingredientsResponse)?  $default,) {final _that = this;
switch (_that) {
case ScanInitial() when $default != null:
return $default(_that.scanState,_that.scanFailure,_that.scanResponse,_that.ingredientsResponse);case _:
  return null;

}
}

}

/// @nodoc


class ScanInitial implements ScanState {
  const ScanInitial({this.scanState = BlocStatus.initial, this.scanFailure, this.scanResponse, final  List<IngredientEntity>? ingredientsResponse}): _ingredientsResponse = ingredientsResponse;
  

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanInitial&&(identical(other.scanState, scanState) || other.scanState == scanState)&&(identical(other.scanFailure, scanFailure) || other.scanFailure == scanFailure)&&(identical(other.scanResponse, scanResponse) || other.scanResponse == scanResponse)&&const DeepCollectionEquality().equals(other._ingredientsResponse, _ingredientsResponse));
}


@override
int get hashCode => Object.hash(runtimeType,scanState,scanFailure,scanResponse,const DeepCollectionEquality().hash(_ingredientsResponse));

@override
String toString() {
  return 'ScanState(scanState: $scanState, scanFailure: $scanFailure, scanResponse: $scanResponse, ingredientsResponse: $ingredientsResponse)';
}


}

/// @nodoc
abstract mixin class $ScanInitialCopyWith<$Res> implements $ScanStateCopyWith<$Res> {
  factory $ScanInitialCopyWith(ScanInitial value, $Res Function(ScanInitial) _then) = _$ScanInitialCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus scanState, Failure? scanFailure, ScanEntity? scanResponse, List<IngredientEntity>? ingredientsResponse
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
@override @pragma('vm:prefer-inline') $Res call({Object? scanState = null,Object? scanFailure = freezed,Object? scanResponse = freezed,Object? ingredientsResponse = freezed,}) {
  return _then(ScanInitial(
scanState: null == scanState ? _self.scanState : scanState // ignore: cast_nullable_to_non_nullable
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
