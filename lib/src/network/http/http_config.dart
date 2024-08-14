part of http;

@immutable
abstract class HttpConfig {
  /// Creates an immutable instace of [HttpConfig].
  factory HttpConfig({
    required String baseUrl,
    Map<String, String> defaultHeaders,
  }) = _HttpConfig;

  Uri get baseUrl;

  Map<String, String> get defaultHeaders;
}

/// Not actually 'mutable' but since both
/// [baseUrl] and [defaultHeaders] are getters,
/// we can change the values from the outside.
class MutableHttpConfig implements HttpConfig {
  MutableHttpConfig({
    required String Function() baseUrl,
    Map<String, String> Function()? defaultHeaders,
  })  : _baseUrl = baseUrl,
        _defaultHeaders = defaultHeaders;

  final String Function() _baseUrl;
  @override
  Uri get baseUrl => Uri.parse(_baseUrl());

  final Map<String, String> Function()? _defaultHeaders;
  @override
  Map<String, String> get defaultHeaders => _defaultHeaders?.call() ?? const <String, String>{};
}

class _HttpConfig implements HttpConfig {
  _HttpConfig({
    required String baseUrl,
    this.defaultHeaders = const <String, String>{},
  }) : baseUrl = Uri.parse(baseUrl);

  @override
  final Uri baseUrl;

  @override
  final Map<String, String> defaultHeaders;
}
