import 'package:flutter/widgets.dart';

extension RouteSettingsExtensions on RouteSettings {
  T getArgs<T extends Object?>() {
    final args = getArgsOrNull<T>();
    assert(() {
      if (args is! T) {
        throw ArgumentError.value(
          args,
          'RouteSettings.arguments',
          'Arguments for $name must be $T',
        );
      }
      return true;
    }());
    return args as T;
  }

  T? getArgsOrNull<T extends Object?>() {
    final args = arguments;
    if (args is T) return args;
    return null;
  }
}
