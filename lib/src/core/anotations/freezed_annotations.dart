import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:freezed_annotation/freezed_annotation.dart';

/// Default annotation for Bloc states.
///
/// Example:
/// ```dart
/// class MyBloc extends Bloc<MyEvent, MyState> {
///   ...
/// }
///
/// @freezedBlocState
/// class MyState with _$MyState {
///  const MyState._();
///
///  const factory MyState({
///     @Default(false) bool isLoading,
///     @Default(<String>[]) List<String> items,
///     @Default(null) Exception? error,
///  }) = _MyState;
///
///  static const MyState init = MyState();
/// }
/// ```
const Freezed freezedBlocState = Freezed(
  copyWith: true,
  equal: true,
  makeCollectionsUnmodifiable: true,
  toStringOverride: true,
  map: FreezedMapOptions.none,
);

/// Generates [freezed] code with `copyWith`, equality operators, and
/// `when`+`whenOrNull`+`maybeWhen` methods.
const Freezed freezedEntity = Freezed(
  copyWith: true,
  equal: true,
  makeCollectionsUnmodifiable: true,
  toStringOverride: false,
  map: FreezedMapOptions.none,
);

/// Just like [freezedEntity] but generates `map`, `mapOrNull`, and `maybeMap` methods instead.
const Freezed freezedEntityWithMap = Freezed(
  copyWith: true,
  equal: true,
  makeCollectionsUnmodifiable: true,
  toStringOverride: false,
  when: FreezedWhenOptions.none,
);
