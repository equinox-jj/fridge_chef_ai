// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cookbook_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CookbookEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CookbookEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CookbookEvent()';
}


}

/// @nodoc
class $CookbookEventCopyWith<$Res>  {
$CookbookEventCopyWith(CookbookEvent _, $Res Function(CookbookEvent) __);
}


/// Adds pattern-matching-related methods to [CookbookEvent].
extension CookbookEventPatterns on CookbookEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _Refreshed value)?  refreshed,TResult Function( _ConnectivityChanged value)?  connectivityChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Refreshed() when refreshed != null:
return refreshed(_that);case _ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _Refreshed value)  refreshed,required TResult Function( _ConnectivityChanged value)  connectivityChanged,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _Refreshed():
return refreshed(_that);case _ConnectivityChanged():
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _Refreshed value)?  refreshed,TResult? Function( _ConnectivityChanged value)?  connectivityChanged,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Refreshed() when refreshed != null:
return refreshed(_that);case _ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( bool isOnline)?  connectivityChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Refreshed() when refreshed != null:
return refreshed();case _ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( bool isOnline)  connectivityChanged,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _Refreshed():
return refreshed();case _ConnectivityChanged():
return connectivityChanged(_that.isOnline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( bool isOnline)?  connectivityChanged,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Refreshed() when refreshed != null:
return refreshed();case _ConnectivityChanged() when connectivityChanged != null:
return connectivityChanged(_that.isOnline);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CookbookEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CookbookEvent.started()';
}


}




/// @nodoc


class _Refreshed implements CookbookEvent {
  const _Refreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CookbookEvent.refreshed()';
}


}




/// @nodoc


class _ConnectivityChanged implements CookbookEvent {
  const _ConnectivityChanged({required this.isOnline});
  

 final  bool isOnline;

/// Create a copy of CookbookEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectivityChangedCopyWith<_ConnectivityChanged> get copyWith => __$ConnectivityChangedCopyWithImpl<_ConnectivityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectivityChanged&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline));
}


@override
int get hashCode => Object.hash(runtimeType,isOnline);

@override
String toString() {
  return 'CookbookEvent.connectivityChanged(isOnline: $isOnline)';
}


}

/// @nodoc
abstract mixin class _$ConnectivityChangedCopyWith<$Res> implements $CookbookEventCopyWith<$Res> {
  factory _$ConnectivityChangedCopyWith(_ConnectivityChanged value, $Res Function(_ConnectivityChanged) _then) = __$ConnectivityChangedCopyWithImpl;
@useResult
$Res call({
 bool isOnline
});




}
/// @nodoc
class __$ConnectivityChangedCopyWithImpl<$Res>
    implements _$ConnectivityChangedCopyWith<$Res> {
  __$ConnectivityChangedCopyWithImpl(this._self, this._then);

  final _ConnectivityChanged _self;
  final $Res Function(_ConnectivityChanged) _then;

/// Create a copy of CookbookEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isOnline = null,}) {
  return _then(_ConnectivityChanged(
isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CookbookState {

/// Drives the page: loading skeleton, the grid ([success]), the empty
/// state ([empty]) or the error state.
 BlocStatus get status;/// The saved recipes to render, newest first.
 List<SavedRecipeEntity> get recipes;/// Set when [status] is [BlocStatus.error].
 Failure? get failure;
/// Create a copy of CookbookState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookbookStateCopyWith<CookbookState> get copyWith => _$CookbookStateCopyWithImpl<CookbookState>(this as CookbookState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CookbookState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.recipes, recipes)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(recipes),failure);

@override
String toString() {
  return 'CookbookState(status: $status, recipes: $recipes, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CookbookStateCopyWith<$Res>  {
  factory $CookbookStateCopyWith(CookbookState value, $Res Function(CookbookState) _then) = _$CookbookStateCopyWithImpl;
@useResult
$Res call({
 BlocStatus status, List<SavedRecipeEntity> recipes, Failure? failure
});




}
/// @nodoc
class _$CookbookStateCopyWithImpl<$Res>
    implements $CookbookStateCopyWith<$Res> {
  _$CookbookStateCopyWithImpl(this._self, this._then);

  final CookbookState _self;
  final $Res Function(CookbookState) _then;

/// Create a copy of CookbookState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? recipes = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,recipes: null == recipes ? _self.recipes : recipes // ignore: cast_nullable_to_non_nullable
as List<SavedRecipeEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [CookbookState].
extension CookbookStatePatterns on CookbookState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CookbookState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CookbookState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CookbookState value)  $default,){
final _that = this;
switch (_that) {
case _CookbookState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CookbookState value)?  $default,){
final _that = this;
switch (_that) {
case _CookbookState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlocStatus status,  List<SavedRecipeEntity> recipes,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CookbookState() when $default != null:
return $default(_that.status,_that.recipes,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlocStatus status,  List<SavedRecipeEntity> recipes,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _CookbookState():
return $default(_that.status,_that.recipes,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlocStatus status,  List<SavedRecipeEntity> recipes,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _CookbookState() when $default != null:
return $default(_that.status,_that.recipes,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _CookbookState implements CookbookState {
  const _CookbookState({this.status = BlocStatus.initial, final  List<SavedRecipeEntity> recipes = const <SavedRecipeEntity>[], this.failure}): _recipes = recipes;
  

/// Drives the page: loading skeleton, the grid ([success]), the empty
/// state ([empty]) or the error state.
@override@JsonKey() final  BlocStatus status;
/// The saved recipes to render, newest first.
 final  List<SavedRecipeEntity> _recipes;
/// The saved recipes to render, newest first.
@override@JsonKey() List<SavedRecipeEntity> get recipes {
  if (_recipes is EqualUnmodifiableListView) return _recipes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipes);
}

/// Set when [status] is [BlocStatus.error].
@override final  Failure? failure;

/// Create a copy of CookbookState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CookbookStateCopyWith<_CookbookState> get copyWith => __$CookbookStateCopyWithImpl<_CookbookState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CookbookState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._recipes, _recipes)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_recipes),failure);

@override
String toString() {
  return 'CookbookState(status: $status, recipes: $recipes, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CookbookStateCopyWith<$Res> implements $CookbookStateCopyWith<$Res> {
  factory _$CookbookStateCopyWith(_CookbookState value, $Res Function(_CookbookState) _then) = __$CookbookStateCopyWithImpl;
@override @useResult
$Res call({
 BlocStatus status, List<SavedRecipeEntity> recipes, Failure? failure
});




}
/// @nodoc
class __$CookbookStateCopyWithImpl<$Res>
    implements _$CookbookStateCopyWith<$Res> {
  __$CookbookStateCopyWithImpl(this._self, this._then);

  final _CookbookState _self;
  final $Res Function(_CookbookState) _then;

/// Create a copy of CookbookState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? recipes = null,Object? failure = freezed,}) {
  return _then(_CookbookState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlocStatus,recipes: null == recipes ? _self._recipes : recipes // ignore: cast_nullable_to_non_nullable
as List<SavedRecipeEntity>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
