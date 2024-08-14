import 'package:kartjis_mobile_common/core.dart';

part 'validated_string.freezed.dart';

// NOTE: Please generate this file and ONLY this file using freezed 2.2.1
// There's a bug on version 2.3.0+ that causes the code generator
// to produce the `copyWith` method with `null` as default value
// instead of `freezed`. See https://github.com/rrousselGit/freezed/issues/906
@freezedBlocState
class ValidatedValue<T extends Object> with _$ValidatedValue<T> {
  const factory ValidatedValue({
    @Default(null) T? value,
    @Default(null) IsValid? isValid,
  }) = _ValidatedValue<T>;
  const ValidatedValue._();

  bool get isEmpty => value == null && isValid == null;
}

@freezedBlocState
class ValidatedString with _$ValidatedString {
  const factory ValidatedString({
    @Default('') String value,
    @Default(null) IsValid? isValid,
  }) = _ValidatedString;
  const ValidatedString._();

  static const ValidatedString empty = ValidatedString();

  bool get isEmpty => this == empty;
}

@freezedBlocState
class AsyncValidatedString with _$AsyncValidatedString {
  const factory AsyncValidatedString({
    @Default(false) bool isLoading,
    @Default('') String value,
    @Default(null) IsValid? isValid,
  }) = _AsyncValidatedString;
  const AsyncValidatedString._();

  static const AsyncValidatedString empty = AsyncValidatedString();

  bool get isEmpty => this == empty;
}
