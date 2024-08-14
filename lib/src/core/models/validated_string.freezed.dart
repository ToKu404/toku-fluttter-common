// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validated_string.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ValidatedValue<T extends Object> {
  T? get value => throw _privateConstructorUsedError;
  IsValid? get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValidatedValueCopyWith<T, ValidatedValue<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidatedValueCopyWith<T extends Object, $Res> {
  factory $ValidatedValueCopyWith(
          ValidatedValue<T> value, $Res Function(ValidatedValue<T>) then) =
      _$ValidatedValueCopyWithImpl<T, $Res, ValidatedValue<T>>;
  @useResult
  $Res call({T? value, IsValid? isValid});
}

/// @nodoc
class _$ValidatedValueCopyWithImpl<T extends Object, $Res,
        $Val extends ValidatedValue<T>>
    implements $ValidatedValueCopyWith<T, $Res> {
  _$ValidatedValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isValid = freezed,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T?,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as IsValid?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidatedValueImplCopyWith<T extends Object, $Res>
    implements $ValidatedValueCopyWith<T, $Res> {
  factory _$$ValidatedValueImplCopyWith(_$ValidatedValueImpl<T> value,
          $Res Function(_$ValidatedValueImpl<T>) then) =
      __$$ValidatedValueImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T? value, IsValid? isValid});
}

/// @nodoc
class __$$ValidatedValueImplCopyWithImpl<T extends Object, $Res>
    extends _$ValidatedValueCopyWithImpl<T, $Res, _$ValidatedValueImpl<T>>
    implements _$$ValidatedValueImplCopyWith<T, $Res> {
  __$$ValidatedValueImplCopyWithImpl(_$ValidatedValueImpl<T> _value,
      $Res Function(_$ValidatedValueImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isValid = freezed,
  }) {
    return _then(_$ValidatedValueImpl<T>(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T?,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as IsValid?,
    ));
  }
}

/// @nodoc

class _$ValidatedValueImpl<T extends Object> extends _ValidatedValue<T> {
  const _$ValidatedValueImpl({this.value = null, this.isValid = null})
      : super._();

  @override
  @JsonKey()
  final T? value;
  @override
  @JsonKey()
  final IsValid? isValid;

  @override
  String toString() {
    return 'ValidatedValue<$T>(value: $value, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidatedValueImpl<T> &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(value), isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidatedValueImplCopyWith<T, _$ValidatedValueImpl<T>> get copyWith =>
      __$$ValidatedValueImplCopyWithImpl<T, _$ValidatedValueImpl<T>>(
          this, _$identity);
}

abstract class _ValidatedValue<T extends Object> extends ValidatedValue<T> {
  const factory _ValidatedValue({final T? value, final IsValid? isValid}) =
      _$ValidatedValueImpl<T>;
  const _ValidatedValue._() : super._();

  @override
  T? get value;
  @override
  IsValid? get isValid;
  @override
  @JsonKey(ignore: true)
  _$$ValidatedValueImplCopyWith<T, _$ValidatedValueImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ValidatedString {
  String get value => throw _privateConstructorUsedError;
  IsValid? get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValidatedStringCopyWith<ValidatedString> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidatedStringCopyWith<$Res> {
  factory $ValidatedStringCopyWith(
          ValidatedString value, $Res Function(ValidatedString) then) =
      _$ValidatedStringCopyWithImpl<$Res, ValidatedString>;
  @useResult
  $Res call({String value, IsValid? isValid});
}

/// @nodoc
class _$ValidatedStringCopyWithImpl<$Res, $Val extends ValidatedString>
    implements $ValidatedStringCopyWith<$Res> {
  _$ValidatedStringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isValid = freezed,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as IsValid?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ValidatedStringImplCopyWith<$Res>
    implements $ValidatedStringCopyWith<$Res> {
  factory _$$ValidatedStringImplCopyWith(_$ValidatedStringImpl value,
          $Res Function(_$ValidatedStringImpl) then) =
      __$$ValidatedStringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value, IsValid? isValid});
}

/// @nodoc
class __$$ValidatedStringImplCopyWithImpl<$Res>
    extends _$ValidatedStringCopyWithImpl<$Res, _$ValidatedStringImpl>
    implements _$$ValidatedStringImplCopyWith<$Res> {
  __$$ValidatedStringImplCopyWithImpl(
      _$ValidatedStringImpl _value, $Res Function(_$ValidatedStringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isValid = freezed,
  }) {
    return _then(_$ValidatedStringImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as IsValid?,
    ));
  }
}

/// @nodoc

class _$ValidatedStringImpl extends _ValidatedString {
  const _$ValidatedStringImpl({this.value = '', this.isValid = null})
      : super._();

  @override
  @JsonKey()
  final String value;
  @override
  @JsonKey()
  final IsValid? isValid;

  @override
  String toString() {
    return 'ValidatedString(value: $value, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidatedStringImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidatedStringImplCopyWith<_$ValidatedStringImpl> get copyWith =>
      __$$ValidatedStringImplCopyWithImpl<_$ValidatedStringImpl>(
          this, _$identity);
}

abstract class _ValidatedString extends ValidatedString {
  const factory _ValidatedString({final String value, final IsValid? isValid}) =
      _$ValidatedStringImpl;
  const _ValidatedString._() : super._();

  @override
  String get value;
  @override
  IsValid? get isValid;
  @override
  @JsonKey(ignore: true)
  _$$ValidatedStringImplCopyWith<_$ValidatedStringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AsyncValidatedString {
  bool get isLoading => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  IsValid? get isValid => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AsyncValidatedStringCopyWith<AsyncValidatedString> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AsyncValidatedStringCopyWith<$Res> {
  factory $AsyncValidatedStringCopyWith(AsyncValidatedString value,
          $Res Function(AsyncValidatedString) then) =
      _$AsyncValidatedStringCopyWithImpl<$Res, AsyncValidatedString>;
  @useResult
  $Res call({bool isLoading, String value, IsValid? isValid});
}

/// @nodoc
class _$AsyncValidatedStringCopyWithImpl<$Res,
        $Val extends AsyncValidatedString>
    implements $AsyncValidatedStringCopyWith<$Res> {
  _$AsyncValidatedStringCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? value = null,
    Object? isValid = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as IsValid?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AsyncValidatedStringImplCopyWith<$Res>
    implements $AsyncValidatedStringCopyWith<$Res> {
  factory _$$AsyncValidatedStringImplCopyWith(_$AsyncValidatedStringImpl value,
          $Res Function(_$AsyncValidatedStringImpl) then) =
      __$$AsyncValidatedStringImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String value, IsValid? isValid});
}

/// @nodoc
class __$$AsyncValidatedStringImplCopyWithImpl<$Res>
    extends _$AsyncValidatedStringCopyWithImpl<$Res, _$AsyncValidatedStringImpl>
    implements _$$AsyncValidatedStringImplCopyWith<$Res> {
  __$$AsyncValidatedStringImplCopyWithImpl(_$AsyncValidatedStringImpl _value,
      $Res Function(_$AsyncValidatedStringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? value = null,
    Object? isValid = freezed,
  }) {
    return _then(_$AsyncValidatedStringImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as IsValid?,
    ));
  }
}

/// @nodoc

class _$AsyncValidatedStringImpl extends _AsyncValidatedString {
  const _$AsyncValidatedStringImpl(
      {this.isLoading = false, this.value = '', this.isValid = null})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String value;
  @override
  @JsonKey()
  final IsValid? isValid;

  @override
  String toString() {
    return 'AsyncValidatedString(isLoading: $isLoading, value: $value, isValid: $isValid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AsyncValidatedStringImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isValid, isValid) || other.isValid == isValid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, value, isValid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AsyncValidatedStringImplCopyWith<_$AsyncValidatedStringImpl>
      get copyWith =>
          __$$AsyncValidatedStringImplCopyWithImpl<_$AsyncValidatedStringImpl>(
              this, _$identity);
}

abstract class _AsyncValidatedString extends AsyncValidatedString {
  const factory _AsyncValidatedString(
      {final bool isLoading,
      final String value,
      final IsValid? isValid}) = _$AsyncValidatedStringImpl;
  const _AsyncValidatedString._() : super._();

  @override
  bool get isLoading;
  @override
  String get value;
  @override
  IsValid? get isValid;
  @override
  @JsonKey(ignore: true)
  _$$AsyncValidatedStringImplCopyWith<_$AsyncValidatedStringImpl>
      get copyWith => throw _privateConstructorUsedError;
}
