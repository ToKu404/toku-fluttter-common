part of http;
extension BaseRequestExtensions on BaseRequest {
  BaseRequest copy({
    String? method,
    Uri? url,
  }) {
    final request = this;
    if (request is Request) {
      return request.copy(method: method, url: url);
    } else if (request is MultipartRequest) {
      return request.copy(method: method, url: url);
    } else {
      throw Exception('Unknown request type: $runtimeType');
    }
  }

  String? get authHeader {
    final headers = this.headers.toIgnoreCase();
    final authHeader = headers['authorization'];
    return authHeader;
  }
}

extension RequestExtensions on Request {
  Request copy({
    String? method,
    Uri? url,
  }) {
    return Request(method ?? this.method, url ?? this.url)
      ..bodyBytes = bodyBytes
      ..encoding = encoding
      ..followRedirects = followRedirects
      ..headers.addAll(headers)
      ..persistentConnection = persistentConnection
      ..maxRedirects = maxRedirects;
  }
}

extension MultipartRequestExtensions on MultipartRequest {
  MultipartRequest copy({
    String? method,
    Uri? url,
  }) {
    return MultipartRequest(method ?? this.method, url ?? this.url)
      ..followRedirects = followRedirects
      ..headers.addAll(headers)
      ..persistentConnection = persistentConnection
      ..maxRedirects = maxRedirects
      ..fields.addAll(fields)
      ..files.addAll(files.whereType<ExposedStreamMultipartFile>().map((it) => ExposedStreamMultipartFile(
            it.field,
            it.byteStream,
            it.length,
          )));
  }
}
