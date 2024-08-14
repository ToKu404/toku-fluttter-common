import 'dart:async';

extension CompleterExtensions<T> on Completer<T> {
  void maybeComplete([FutureOr<T>? value]) {
    if (isCompleted) return;
    complete(value);
  }

  void maybeCompleteError(Object error, [StackTrace? stackTrace]) {
    if (isCompleted) return;
    completeError(error, stackTrace);
  }
}
