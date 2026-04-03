// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validated_string.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ValidatedValue<T extends Object> {

 T? get value; IsValid? get isValid;
/// Create a copy of ValidatedValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidatedValueCopyWith<T, ValidatedValue<T>> get copyWith => _$ValidatedValueCopyWithImpl<T, ValidatedValue<T>>(this as ValidatedValue<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidatedValue<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),isValid);

@override
String toString() {
  return 'ValidatedValue<$T>(value: $value, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $ValidatedValueCopyWith<T extends Object,$Res>  {
  factory $ValidatedValueCopyWith(ValidatedValue<T> value, $Res Function(ValidatedValue<T>) _then) = _$ValidatedValueCopyWithImpl;
@useResult
$Res call({
 T? value, IsValid? isValid
});




}
/// @nodoc
class _$ValidatedValueCopyWithImpl<T extends Object,$Res>
    implements $ValidatedValueCopyWith<T, $Res> {
  _$ValidatedValueCopyWithImpl(this._self, this._then);

  final ValidatedValue<T> _self;
  final $Res Function(ValidatedValue<T>) _then;

/// Create a copy of ValidatedValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? isValid = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T?,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as IsValid?,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidatedValue].
extension ValidatedValuePatterns<T extends Object> on ValidatedValue<T> {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T? value,  IsValid? isValid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidatedValue() when $default != null:
return $default(_that.value,_that.isValid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T? value,  IsValid? isValid)  $default,) {final _that = this;
switch (_that) {
case _ValidatedValue():
return $default(_that.value,_that.isValid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T? value,  IsValid? isValid)?  $default,) {final _that = this;
switch (_that) {
case _ValidatedValue() when $default != null:
return $default(_that.value,_that.isValid);case _:
  return null;

}
}

}

/// @nodoc


class _ValidatedValue<T extends Object> extends ValidatedValue<T> {
  const _ValidatedValue({this.value = null, this.isValid = null}): super._();
  

@override@JsonKey() final  T? value;
@override@JsonKey() final  IsValid? isValid;

/// Create a copy of ValidatedValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidatedValueCopyWith<T, _ValidatedValue<T>> get copyWith => __$ValidatedValueCopyWithImpl<T, _ValidatedValue<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidatedValue<T>&&const DeepCollectionEquality().equals(other.value, value)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value),isValid);

@override
String toString() {
  return 'ValidatedValue<$T>(value: $value, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class _$ValidatedValueCopyWith<T extends Object,$Res> implements $ValidatedValueCopyWith<T, $Res> {
  factory _$ValidatedValueCopyWith(_ValidatedValue<T> value, $Res Function(_ValidatedValue<T>) _then) = __$ValidatedValueCopyWithImpl;
@override @useResult
$Res call({
 T? value, IsValid? isValid
});




}
/// @nodoc
class __$ValidatedValueCopyWithImpl<T extends Object,$Res>
    implements _$ValidatedValueCopyWith<T, $Res> {
  __$ValidatedValueCopyWithImpl(this._self, this._then);

  final _ValidatedValue<T> _self;
  final $Res Function(_ValidatedValue<T>) _then;

/// Create a copy of ValidatedValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? isValid = freezed,}) {
  return _then(_ValidatedValue<T>(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T?,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as IsValid?,
  ));
}


}

/// @nodoc
mixin _$ValidatedString {

 String get value; IsValid? get isValid;
/// Create a copy of ValidatedString
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidatedStringCopyWith<ValidatedString> get copyWith => _$ValidatedStringCopyWithImpl<ValidatedString>(this as ValidatedString, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidatedString&&(identical(other.value, value) || other.value == value)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,value,isValid);

@override
String toString() {
  return 'ValidatedString(value: $value, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $ValidatedStringCopyWith<$Res>  {
  factory $ValidatedStringCopyWith(ValidatedString value, $Res Function(ValidatedString) _then) = _$ValidatedStringCopyWithImpl;
@useResult
$Res call({
 String value, IsValid? isValid
});




}
/// @nodoc
class _$ValidatedStringCopyWithImpl<$Res>
    implements $ValidatedStringCopyWith<$Res> {
  _$ValidatedStringCopyWithImpl(this._self, this._then);

  final ValidatedString _self;
  final $Res Function(ValidatedString) _then;

/// Create a copy of ValidatedString
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isValid = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as IsValid?,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidatedString].
extension ValidatedStringPatterns on ValidatedString {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  IsValid? isValid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidatedString() when $default != null:
return $default(_that.value,_that.isValid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  IsValid? isValid)  $default,) {final _that = this;
switch (_that) {
case _ValidatedString():
return $default(_that.value,_that.isValid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  IsValid? isValid)?  $default,) {final _that = this;
switch (_that) {
case _ValidatedString() when $default != null:
return $default(_that.value,_that.isValid);case _:
  return null;

}
}

}

/// @nodoc


class _ValidatedString extends ValidatedString {
  const _ValidatedString({this.value = '', this.isValid = null}): super._();
  

@override@JsonKey() final  String value;
@override@JsonKey() final  IsValid? isValid;

/// Create a copy of ValidatedString
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidatedStringCopyWith<_ValidatedString> get copyWith => __$ValidatedStringCopyWithImpl<_ValidatedString>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidatedString&&(identical(other.value, value) || other.value == value)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,value,isValid);

@override
String toString() {
  return 'ValidatedString(value: $value, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class _$ValidatedStringCopyWith<$Res> implements $ValidatedStringCopyWith<$Res> {
  factory _$ValidatedStringCopyWith(_ValidatedString value, $Res Function(_ValidatedString) _then) = __$ValidatedStringCopyWithImpl;
@override @useResult
$Res call({
 String value, IsValid? isValid
});




}
/// @nodoc
class __$ValidatedStringCopyWithImpl<$Res>
    implements _$ValidatedStringCopyWith<$Res> {
  __$ValidatedStringCopyWithImpl(this._self, this._then);

  final _ValidatedString _self;
  final $Res Function(_ValidatedString) _then;

/// Create a copy of ValidatedString
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isValid = freezed,}) {
  return _then(_ValidatedString(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as IsValid?,
  ));
}


}

/// @nodoc
mixin _$AsyncValidatedString {

 bool get isLoading; String get value; IsValid? get isValid;
/// Create a copy of AsyncValidatedString
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AsyncValidatedStringCopyWith<AsyncValidatedString> get copyWith => _$AsyncValidatedStringCopyWithImpl<AsyncValidatedString>(this as AsyncValidatedString, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AsyncValidatedString&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.value, value) || other.value == value)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,value,isValid);

@override
String toString() {
  return 'AsyncValidatedString(isLoading: $isLoading, value: $value, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $AsyncValidatedStringCopyWith<$Res>  {
  factory $AsyncValidatedStringCopyWith(AsyncValidatedString value, $Res Function(AsyncValidatedString) _then) = _$AsyncValidatedStringCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String value, IsValid? isValid
});




}
/// @nodoc
class _$AsyncValidatedStringCopyWithImpl<$Res>
    implements $AsyncValidatedStringCopyWith<$Res> {
  _$AsyncValidatedStringCopyWithImpl(this._self, this._then);

  final AsyncValidatedString _self;
  final $Res Function(AsyncValidatedString) _then;

/// Create a copy of AsyncValidatedString
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? value = null,Object? isValid = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as IsValid?,
  ));
}

}


/// Adds pattern-matching-related methods to [AsyncValidatedString].
extension AsyncValidatedStringPatterns on AsyncValidatedString {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String value,  IsValid? isValid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AsyncValidatedString() when $default != null:
return $default(_that.isLoading,_that.value,_that.isValid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String value,  IsValid? isValid)  $default,) {final _that = this;
switch (_that) {
case _AsyncValidatedString():
return $default(_that.isLoading,_that.value,_that.isValid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String value,  IsValid? isValid)?  $default,) {final _that = this;
switch (_that) {
case _AsyncValidatedString() when $default != null:
return $default(_that.isLoading,_that.value,_that.isValid);case _:
  return null;

}
}

}

/// @nodoc


class _AsyncValidatedString extends AsyncValidatedString {
  const _AsyncValidatedString({this.isLoading = false, this.value = '', this.isValid = null}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String value;
@override@JsonKey() final  IsValid? isValid;

/// Create a copy of AsyncValidatedString
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AsyncValidatedStringCopyWith<_AsyncValidatedString> get copyWith => __$AsyncValidatedStringCopyWithImpl<_AsyncValidatedString>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AsyncValidatedString&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.value, value) || other.value == value)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,value,isValid);

@override
String toString() {
  return 'AsyncValidatedString(isLoading: $isLoading, value: $value, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class _$AsyncValidatedStringCopyWith<$Res> implements $AsyncValidatedStringCopyWith<$Res> {
  factory _$AsyncValidatedStringCopyWith(_AsyncValidatedString value, $Res Function(_AsyncValidatedString) _then) = __$AsyncValidatedStringCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String value, IsValid? isValid
});




}
/// @nodoc
class __$AsyncValidatedStringCopyWithImpl<$Res>
    implements _$AsyncValidatedStringCopyWith<$Res> {
  __$AsyncValidatedStringCopyWithImpl(this._self, this._then);

  final _AsyncValidatedString _self;
  final $Res Function(_AsyncValidatedString) _then;

/// Create a copy of AsyncValidatedString
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? value = null,Object? isValid = freezed,}) {
  return _then(_AsyncValidatedString(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as IsValid?,
  ));
}


}

// dart format on
