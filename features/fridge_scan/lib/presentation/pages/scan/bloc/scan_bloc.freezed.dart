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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScanConfirmed value)?  confirmed,TResult Function( ScanReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScanConfirmed() when confirmed != null:
return confirmed(_that);case ScanReset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScanConfirmed value)  confirmed,required TResult Function( ScanReset value)  reset,}){
final _that = this;
switch (_that) {
case ScanConfirmed():
return confirmed(_that);case ScanReset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScanConfirmed value)?  confirmed,TResult? Function( ScanReset value)?  reset,}){
final _that = this;
switch (_that) {
case ScanConfirmed() when confirmed != null:
return confirmed(_that);case ScanReset() when reset != null:
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
case ScanConfirmed() when confirmed != null:
return confirmed(_that.file);case ScanReset() when reset != null:
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
case ScanConfirmed():
return confirmed(_that.file);case ScanReset():
return reset();}
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
case ScanConfirmed() when confirmed != null:
return confirmed(_that.file);case ScanReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class ScanConfirmed implements ScanEvent {
  const ScanConfirmed(this.file);
  

 final  XFile file;

/// Create a copy of ScanEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanConfirmedCopyWith<ScanConfirmed> get copyWith => _$ScanConfirmedCopyWithImpl<ScanConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanConfirmed&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'ScanEvent.confirmed(file: $file)';
}


}

/// @nodoc
abstract mixin class $ScanConfirmedCopyWith<$Res> implements $ScanEventCopyWith<$Res> {
  factory $ScanConfirmedCopyWith(ScanConfirmed value, $Res Function(ScanConfirmed) _then) = _$ScanConfirmedCopyWithImpl;
@useResult
$Res call({
 XFile file
});




}
/// @nodoc
class _$ScanConfirmedCopyWithImpl<$Res>
    implements $ScanConfirmedCopyWith<$Res> {
  _$ScanConfirmedCopyWithImpl(this._self, this._then);

  final ScanConfirmed _self;
  final $Res Function(ScanConfirmed) _then;

/// Create a copy of ScanEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(ScanConfirmed(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as XFile,
  ));
}


}

/// @nodoc


class ScanReset implements ScanEvent {
  const ScanReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanReset);
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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanState()';
}


}

/// @nodoc
class $ScanStateCopyWith<$Res>  {
$ScanStateCopyWith(ScanState _, $Res Function(ScanState) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScanInitial value)?  initial,TResult Function( ScanLoading value)?  loading,TResult Function( ScanDone value)?  done,TResult Function( ScanError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScanInitial() when initial != null:
return initial(_that);case ScanLoading() when loading != null:
return loading(_that);case ScanDone() when done != null:
return done(_that);case ScanError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScanInitial value)  initial,required TResult Function( ScanLoading value)  loading,required TResult Function( ScanDone value)  done,required TResult Function( ScanError value)  error,}){
final _that = this;
switch (_that) {
case ScanInitial():
return initial(_that);case ScanLoading():
return loading(_that);case ScanDone():
return done(_that);case ScanError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScanInitial value)?  initial,TResult? Function( ScanLoading value)?  loading,TResult? Function( ScanDone value)?  done,TResult? Function( ScanError value)?  error,}){
final _that = this;
switch (_that) {
case ScanInitial() when initial != null:
return initial(_that);case ScanLoading() when loading != null:
return loading(_that);case ScanDone() when done != null:
return done(_that);case ScanError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ScanEntity scan,  List<IngredientEntity> ingredients)?  done,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScanInitial() when initial != null:
return initial();case ScanLoading() when loading != null:
return loading();case ScanDone() when done != null:
return done(_that.scan,_that.ingredients);case ScanError() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ScanEntity scan,  List<IngredientEntity> ingredients)  done,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case ScanInitial():
return initial();case ScanLoading():
return loading();case ScanDone():
return done(_that.scan,_that.ingredients);case ScanError():
return error(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ScanEntity scan,  List<IngredientEntity> ingredients)?  done,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case ScanInitial() when initial != null:
return initial();case ScanLoading() when loading != null:
return loading();case ScanDone() when done != null:
return done(_that.scan,_that.ingredients);case ScanError() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ScanInitial implements ScanState {
  const ScanInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanState.initial()';
}


}




/// @nodoc


class ScanLoading implements ScanState {
  const ScanLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScanState.loading()';
}


}




/// @nodoc


class ScanDone implements ScanState {
  const ScanDone(this.scan, final  List<IngredientEntity> ingredients): _ingredients = ingredients;
  

 final  ScanEntity scan;
 final  List<IngredientEntity> _ingredients;
 List<IngredientEntity> get ingredients {
  if (_ingredients is EqualUnmodifiableListView) return _ingredients;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ingredients);
}


/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanDoneCopyWith<ScanDone> get copyWith => _$ScanDoneCopyWithImpl<ScanDone>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanDone&&(identical(other.scan, scan) || other.scan == scan)&&const DeepCollectionEquality().equals(other._ingredients, _ingredients));
}


@override
int get hashCode => Object.hash(runtimeType,scan,const DeepCollectionEquality().hash(_ingredients));

@override
String toString() {
  return 'ScanState.done(scan: $scan, ingredients: $ingredients)';
}


}

/// @nodoc
abstract mixin class $ScanDoneCopyWith<$Res> implements $ScanStateCopyWith<$Res> {
  factory $ScanDoneCopyWith(ScanDone value, $Res Function(ScanDone) _then) = _$ScanDoneCopyWithImpl;
@useResult
$Res call({
 ScanEntity scan, List<IngredientEntity> ingredients
});


$ScanEntityCopyWith<$Res> get scan;

}
/// @nodoc
class _$ScanDoneCopyWithImpl<$Res>
    implements $ScanDoneCopyWith<$Res> {
  _$ScanDoneCopyWithImpl(this._self, this._then);

  final ScanDone _self;
  final $Res Function(ScanDone) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scan = null,Object? ingredients = null,}) {
  return _then(ScanDone(
null == scan ? _self.scan : scan // ignore: cast_nullable_to_non_nullable
as ScanEntity,null == ingredients ? _self._ingredients : ingredients // ignore: cast_nullable_to_non_nullable
as List<IngredientEntity>,
  ));
}

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScanEntityCopyWith<$Res> get scan {
  
  return $ScanEntityCopyWith<$Res>(_self.scan, (value) {
    return _then(_self.copyWith(scan: value));
  });
}
}

/// @nodoc


class ScanError implements ScanState {
  const ScanError(this.failure);
  

 final  Failure failure;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanErrorCopyWith<ScanError> get copyWith => _$ScanErrorCopyWithImpl<ScanError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ScanState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ScanErrorCopyWith<$Res> implements $ScanStateCopyWith<$Res> {
  factory $ScanErrorCopyWith(ScanError value, $Res Function(ScanError) _then) = _$ScanErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ScanErrorCopyWithImpl<$Res>
    implements $ScanErrorCopyWith<$Res> {
  _$ScanErrorCopyWithImpl(this._self, this._then);

  final ScanError _self;
  final $Res Function(ScanError) _then;

/// Create a copy of ScanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ScanError(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
