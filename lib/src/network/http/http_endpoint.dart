part of http;

typedef HttpOnData<T> = T Function(Map<String, dynamic> json);

enum AuthType { none, basic, session }

abstract class HttpEndpointBase<T> {
  String get path;
  HttpMethod get method;
  AuthType get authType;

  /// Flags to be used by [Interceptor], usually to determine
  /// whether to handle this endpoint or not.
  Map<Object, Object?>? get flags;

  T onResponse(covariant BaseResponse response);

  @visibleForTesting
  static bool isValidResponseFor<T>(HttpResponse response) {
    if (!response.isJsonResponse) throw BadResponseFormatException();
    return response.hasBodyResponse && response.bodyResponse is T;
  }
}

@optionalTypeArgs
class HttpEndpoint<T> implements HttpEndpointBase<T> {
  const HttpEndpoint({
    required this.path,
    required this.method,
    required this.authType,
    this.flags,
    HttpOnData<T>? onData,
  }) : _onDataFn = onData;

  @override
  final String path;

  @override
  final HttpMethod method;

  @override
  final AuthType authType;

  @override
  final Map<Object, Object?>? flags;

  final HttpOnData<T>? _onDataFn;

  @override
  T onResponse(HttpResponse response) {
    if (_onDataFn != null && HttpEndpointBase.isValidResponseFor<JsonMap>(response)) {
      return _onDataFn(response.bodyResponse! as Map<String, dynamic>);
    }
    if (response.bodyResponse is! T) throw BadResponseFormatException();
    return response.bodyResponse as T;
  }
}

class HttpListEndpoint<T> implements HttpEndpointBase<List<T>> {
  const HttpListEndpoint({
    required this.path,
    required this.method,
    required this.authType,
    this.flags,
    HttpOnData<T>? onData,
  }) : _onDataFn = onData;

  @override
  final String path;

  @override
  final HttpMethod method;

  @override
  final AuthType authType;

  @override
  final Map<Object, Object?>? flags;

  final HttpOnData<T>? _onDataFn;

  @override
  List<T> onResponse(HttpResponse response) {
    debugPrint(response.body);
    debugPrint((_onDataFn!=null).toString());

    if (_onDataFn != null && HttpEndpointBase.isValidResponseFor<List<dynamic>>(response)) {
      final bodyResponse = response.bodyResponse! as List<dynamic>;
      return bodyResponse.whereType<JsonMap>().map((it) => _onDataFn!(it)).toList();
    }
    if (response.bodyResponse is! List<dynamic>) throw BadResponseFormatException();
    return (response.bodyResponse! as List<dynamic>).cast<T>();
  }
}

class HttpBytesEndpoint implements HttpEndpointBase<Uint8List> {
  const HttpBytesEndpoint({
    required this.path,
    required this.method,
    required this.authType,
    this.flags,
  });

  @override
  final String path;

  @override
  final HttpMethod method;

  @override
  final AuthType authType;

  @override
  final Map<Object, Object?>? flags;

  @override
  Uint8List onResponse(HttpResponse response) => response.bodyBytes;
}
