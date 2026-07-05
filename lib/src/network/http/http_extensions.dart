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
    final copiedRequest =
        MultipartRequest(method ?? this.method, url ?? this.url)
          ..followRedirects = followRedirects
          ..headers.addAll(headers)
          ..persistentConnection = persistentConnection
          ..maxRedirects = maxRedirects
          ..fields.addAll(fields);

    for (final file in files) {
      if (file is ExposedStreamMultipartFile) {
        copiedRequest.files.add(
          ExposedStreamMultipartFile(
            file.field,
            file.byteStream,
            file.length,
            filename: file.filename,
            contentType: file.contentType,
          ),
        );
      } else {
        copiedRequest.files.add(file);
      }
    }

    return copiedRequest;
  }
}
