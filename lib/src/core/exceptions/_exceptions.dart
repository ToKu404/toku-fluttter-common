class UnknownErrorException implements Exception {
  UnknownErrorException([this.error]);

  final Object? error;

  @override
  String toString() => 'Unknown Error';
}

class CustomException implements Exception {
  CustomException(
    this.message, {
    this.error,
    this.stackTrace,
  });

  final Object? error;
  final StackTrace? stackTrace;
  final String message;

  @override
  String toString() => message;
}

class TaggedException implements Exception {
  TaggedException(this.exception, this.tags);

  final Exception exception;
  final Map<Object, Object> tags;

  @override
  String toString() => exception.toString();
}
