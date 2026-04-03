import 'package:toku_flutter_common/core.dart';

part 'validated_string.freezed.dart';

@freezedBlocState
abstract class ValidatedValue<T extends Object> with _$ValidatedValue<T> {
  const factory ValidatedValue({
    @Default(null) T? value,
    @Default(null) IsValid? isValid,
  }) = _ValidatedValue<T>;
  const ValidatedValue._();

  bool get isEmpty => value == null && isValid == null;
}

@freezedBlocState
abstract class ValidatedString with _$ValidatedString {
  const factory ValidatedString({
    @Default('') String value,
    @Default(null) IsValid? isValid,
  }) = _ValidatedString;
  const ValidatedString._();

  static const ValidatedString empty = ValidatedString();

  bool get isEmpty => this == empty;
}

@freezedBlocState
abstract class AsyncValidatedString with _$AsyncValidatedString {
  const factory AsyncValidatedString({
    @Default(false) bool isLoading,
    @Default('') String value,
    @Default(null) IsValid? isValid,
  }) = _AsyncValidatedString;
  const AsyncValidatedString._();

  static const AsyncValidatedString empty = AsyncValidatedString();

  bool get isEmpty => this == empty;
}
