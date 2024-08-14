part of http;

class HttpRequest {
  const HttpRequest({
    this.contentType,
    this.headers,
    this.queryParameters,
    this.queryVariables,
    this.body = HttpRequestBody.empty,
  });

  final HttpContentType? contentType;

  final Map<String, String>? headers;

  final Map<String, String>? queryParameters;

  /// This is used to replace query parameters in curly-brackets.
  ///
  /// Example:
  /// ```dart
  /// ...
  /// String get endpoint => 'api/{id}/list'
  /// ...
  /// ...
  /// final HttpRequest request = HttpRequest({
  ///   queryVariables: <String, String>{
  ///     'id': 'id-1',
  ///   },
  /// });
  /// ...
  /// ```
  /// Here `id` in the [queryVariables] will be used to replace the `{id}`
  /// in the `endpoint`.
  ///
  final Map<String, String>? queryVariables;

  final HttpRequestBody body;

  static const HttpRequest empty = HttpRequest();
}
