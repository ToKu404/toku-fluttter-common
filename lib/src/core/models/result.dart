import 'dart:async';
import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// A union data class that represents the result of an operation that
/// can either be successful or failed.
///
/// Use this class to 'force' the consumers of your API to handle both
/// cases, or to provide a default value in case of failure.
///
/// ### Example for producing
/// ```dart
/// Future<Result<String>> asyncFunctionThatMayFail() async {
///   try {
///     final String value = await apiCallThatMayFail();
///     return Result.success(value);
///   } on Exception catch (e) {
///     return Result.error(e);
///   }
/// }
/// ```
///
/// ### Example for consuming
/// ```dart
/// final Result<String> resultAsync = await asyncFunctionThatMayFail();
///
/// resultAsync.when(
///   success: (String value) => print(value),
///   error: (Exception error) => print(error),
/// );
///
/// final String? optionalResult = resultAsync.whenOrNull(
///   success: (String value) => value,
/// );
///
/// final String resultWithFallback = resultAsync.maybeWhen(
///   success: (String value) => value,
///   orElse: () => 'fallback',
/// );
/// ```
@Freezed(
  map: FreezedMapOptions.none,
  toStringOverride: false,
  equal: false,
  copyWith: false,
)
@optionalTypeArgs
class Result<T> with _$Result<T> {
  const Result._();

  /// Creates a [Result] for a successful operation that returns [T].
  const factory Result.success(T value) = _Success<T>;

  /// Creates a [Result] for a failed operation that throws [Exception].
  const factory Result.error(Exception error) = _Error<T>;

  bool get isSuccess => this is _Success<T>;
  bool get isError => this is _Error<T>;

  T? getValue() => whenOrNull(success: (T value) => value);

  Exception? getError() => whenOrNull(error: (Exception error) => error);

  Result<T2> andThen0<T2>(Result<T2> Function() mapper) {
    return andThen((_) => mapper());
  }

  Future<Result<T2>> andThenAsync0<T2>(FutureOr<Result<T2>> Function() mapper) {
    return andThenAsync((_) => mapper());
  }

  Result<T2> andThen<T2>(Result<T2> Function(T value) mapper) {
    return when(
      success: mapper,
      error: Result<T2>.error,
    );
  }

  Future<Result<T2>> andThenAsync<T2>(FutureOr<Result<T2>> Function(T value) mapper) async {
    return when(
      success: mapper,
      error: Result<T2>.error,
    );
  }

  Result<T2> map0<T2>(T2 Function() mapper) {
    return map((_) => mapper());
  }

  Future<Result<T2>> mapAsync0<T2>(FutureOr<T2> Function() mapper) async {
    return mapAsync((_) => mapper());
  }

  Result<T2> map<T2>(T2 Function(T value) mapper) {
    return when(
      success: (T value) => Result.success(mapper(value)),
      error: Result<T2>.error,
    );
  }

  Future<Result<T2>> mapAsync<T2>(FutureOr<T2> Function(T value) mapper) async {
    return when(
      success: (T value) async => Result.success(await mapper(value)),
      error: Result<T2>.error,
    );
  }

  Result<T> mapError(Exception Function(Exception error) errMapper) {
    return when(
      success: Result<T>.success,
      error: (Exception error) => Result.error(errMapper(error)),
    );
  }
}

extension FutureResultExtension<T> on Future<Result<T>> {
  Future<Result<T2>> andThenAsync0<T2>(FutureOr<Result<T2>> Function() mapper) async {
    return then((Result<T> result) => result.andThenAsync0(mapper));
  }

  Future<Result<T2>> andThenAsync<T2>(FutureOr<Result<T2>> Function(T value) mapper) {
    return then((Result<T> result) => result.andThenAsync(mapper));
  }

  Future<Result<T2>> mapAsync0<T2>(FutureOr<T2> Function() mapper) {
    return then(
      (Result<T> result) => result.when<FutureOr<Result<T2>>>(
        success: (_) async => Result<T2>.success(await mapper()),
        error: Result<T2>.error,
      ),
    );
  }

  Future<Result<T2>> mapAsync<T2>(FutureOr<T2> Function(T value) mapper) {
    return then(
      (Result<T> result) => result.when<FutureOr<Result<T2>>>(
        success: (T value) async => Result<T2>.success(await mapper(value)),
        error: Result<T2>.error,
      ),
    );
  }

  Future<Result<T>> mapErrorAsync(FutureOr<Exception> Function(Exception error) errMapper) {
    return then(
      (Result<T> result) => result.when<FutureOr<Result<T>>>(
        success: Result<T>.success,
        error: (Exception error) async => Result<T>.error(await errMapper(error)),
      ),
    );
  }

  Future<T2> whenAsync<T2>({
    required FutureOr<T2> Function(T value) success,
    required FutureOr<T2> Function(Exception error) error,
  }) {
    return then(
      (Result<T> result) => result.when(
        success: success,
        error: error,
      ),
    );
  }

  /// Combines multiple `Future<Result<T>>` into a single `Future<Result<List<dynamic>>>`.
  /// 
  /// Example:
  /// ```dart
  /// Future<Result<int>> getOne() async => const Result.success(1);
  /// Future<Result<bool>> getTrue() async => const Result.success(true);
  /// Future<Result<String>> getHello() async => const Result.success('hello');
  /// 
  /// final result = getOne()
  ///   .andThenCombineAsync(getTrue)
  ///   .andThenCombineAsync(getHello)
  ///   .mapAsync((results) => (
  ///     results[0] as int, // <- from getOne()
  ///     results[1] as bool, // <- from getTrue()
  ///     results[2] as String, // <- from getHello()
  ///   ));
  /// print(result); // Result<(int, bool, String)>
  /// print(result.getValue()); // (1, true, 'hello')
  /// ```
  Future<Result<List<dynamic>>> andThenCombineAsync<T2>(Future<Result<T2>> Function() next) {
    return andThenAsync((it) => next().mapAsync((it2) => _CombinedResults.from([it, it2])));
  }
}

class _CombinedResults extends UnmodifiableListView<dynamic> {
  _CombinedResults(this.results) : super(results);

  factory _CombinedResults.from(List<dynamic> results) {
    if (results is _CombinedResults) return results;
    if (results.isNotEmpty && results.first is _CombinedResults) {
      final first = results.first! as _CombinedResults;
      return _CombinedResults([
        ...first.results,
        ...results.skip(1),
      ]);
    }
    return _CombinedResults(results);
  }

  final List<Object?> results;
}
