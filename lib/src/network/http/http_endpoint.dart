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
    // if (!response.isJsonResponse) throw BadResponseFormatException();
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
    if (HttpEndpointBase.isValidResponseFor<JsonMap>(response) && _onDataFn != null) {
      return _onDataFn(response.bodyResponse! as Map<String, dynamic>);
    }
    return true as T;
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
    if (response.bodyJson != null && _onDataFn != null) {
      final bodyResponse = response.bodyJson!['data']! as List<dynamic>;
      return bodyResponse.whereType<JsonMap>().map((it) => _onDataFn(it)).toList();
    }
    return response.bodyResponse! as List<T>;
  }
}

class HttpExternalEndpoint<T> implements HttpEndpointBase<T> {
  const HttpExternalEndpoint({
    required this.path,
    required this.method,
    this.authType = AuthType.none,
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
    if (response.isJsonResponse) return _onDataFn!(response.bodyJson!);
    return response.bodyJson as T;
  }
}

class HttpFileResponse {
  const HttpFileResponse({
    required this.bytes,
    required this.headers,
    this.filename,
    this.contentType,
  });

  /// Raw file bytes (Excel, PDF, dll).
  final Uint8List bytes;

  /// Nama file yang diambil dari `Content-Disposition`, kalau ada.
  final String? filename;

  /// MIME-type dari header `Content-Type`.
  final String? contentType;

  /// Semua response headers, kalau mau dipakai lagi di atas.
  final Map<String, String> headers;
}

class HttpFileEndpoint extends HttpEndpointBase<HttpFileResponse> {
  HttpFileEndpoint({
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
  HttpFileResponse onResponse(HttpResponse response) {
    final headers = response.headers;
    final contentDisposition = headers['content-disposition'];
    final contentType = headers['content-type'];

    final filename = _extractFilenameFromContentDisposition(contentDisposition);

    return HttpFileResponse(
      bytes: response.bodyBytes,
      headers: headers,
      filename: filename,
      contentType: contentType,
    );
  }

  String? _extractFilenameFromContentDisposition(String? cd) {
    if (cd == null) return null;

    // contoh header: attachment; filename=customers-20251105-175715.xlsx
    // atau: attachment; filename="customers-20251105-175715.xlsx"
    final lower = cd.toLowerCase();
    final idx = lower.indexOf('filename=');
    if (idx == -1) return null;

    var value = cd.substring(idx + 'filename='.length).trim();

    // buang titik koma sisa, kalau ada
    final semicolonIndex = value.indexOf(';');
    if (semicolonIndex != -1) {
      value = value.substring(0, semicolonIndex).trim();
    }

    if (value.startsWith('"') && value.endsWith('"') && value.length >= 2) {
      value = value.substring(1, value.length - 1);
    }

    return value;
  }
}
