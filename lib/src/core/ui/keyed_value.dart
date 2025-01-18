import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef KeyedString = KeyedValue<String>;
typedef KeyedBool = KeyedValue<bool>;

@immutable
class KeyedValue<T extends Object?> extends Equatable {
  const KeyedValue({
    required this.key,
    required this.value,
  });

  /// {@template core.base.KeyedValue.of}
  /// Creates a [KeyedValue] with a unique [key].
  /// {@endtemplate}
  KeyedValue.of(this.value) : key = Object();

  final Object key;
  final T value;

  @override
  List<Object?> get props => <Object?>[key, value];
}
