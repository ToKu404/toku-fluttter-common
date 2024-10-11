part of http;

class HttpResponse extends Response {
  /// Creates a new HTTP response with a string body.
  HttpResponse(
    super.body,
    super.statusCode, {
    super.request,
    super.headers,
    super.isRedirect,
    super.persistentConnection,
    super.reasonPhrase,
  });

  /// Create a new HTTP response with a byte array body.
  HttpResponse.bytes(
    List<int> bodyBytes,
    int statusCode, {
    BaseRequest? request,
    Map<String, String> headers = const <String, String>{},
    bool isRedirect = false,
    bool persistentConnection = true,
    String? reasonPhrase,
  }) : super.bytes(
          bodyBytes,
          statusCode,
          request: request,
          headers: headers,
          isRedirect: isRedirect,
          persistentConnection: persistentConnection,
          reasonPhrase: reasonPhrase,
        );

  /// Creates a new HTTP response by waiting for the full body to become
  /// available from a [StreamedResponse].
  static Future<HttpResponse> fromStream(StreamedResponse response) async {
    final body = await response.stream.toBytes();
    return HttpResponse.bytes(
      body,
      response.statusCode,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  bool? _isJsonResponse;
  bool get isJsonResponse {
    if (_isJsonResponse != null) return _isJsonResponse!;
    final headers = this.headers.toIgnoreCase();
    final contentType = headers['content-type'];
    return _isJsonResponse = contentType?.toLowerCase().contains('application/json') == true;
  }

  Map<String, dynamic>? _bodyJson;
  Map<String, dynamic>? get bodyJson {
    if (_bodyJson != null) return _bodyJson!;
    if (!isJsonResponse) return null;
    return _bodyJson = jsonDecode(body) as Map<String, dynamic>;
  }

  bool? _hasBodyResponse;

  /// Whether the body json has a "response" key.
  bool get hasBodyResponse => _hasBodyResponse ?? bodyResponse != null;

  Object? _bodyResponse;

  /// The value of the "response" key in the body json.
  /// This can be a [Map<String, dynamic>] or a primitive-type value (e.g. [bool], [String], etc.).
  Object? get bodyResponse {
    if (_bodyResponse != null) return _bodyResponse!;

    final bodyJson = this.bodyJson;
    if (bodyJson == null || _hasBodyResponse == false) return null;

    if (!bodyJson.containsKey('response')) {
      _hasBodyResponse = false;
      return null;
    }

    _hasBodyResponse = true;
    return _bodyResponse = bodyJson['response'];
  }

  bool? _hasBodyError;

  /// Whether the body json has an "error" key.
  bool get hasBodyError => _hasBodyError ?? bodyError != null;

  Map<String, dynamic>? _bodyError;
  Map<String, dynamic>? get bodyError {
    if (_bodyError != null) return _bodyError!;

    final bodyJson = this.bodyJson;
    if (bodyJson == null || _hasBodyError == false) return null;

    final dynamic error = bodyJson['error'];
    if (error is! Map<String, dynamic>) {
      _hasBodyError = false;
      return null;
    }

    _hasBodyError = true;
    return _bodyError = error;
  }
}
