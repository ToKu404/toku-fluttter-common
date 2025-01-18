import 'dart:async';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
// ignore: always_use_package_imports
import 'raw_stub_http_client.dart'
    if (dart.library.io) 'raw_io_http_client.dart'
    if (dart.library.html) 'raw_browser_http_client.dart';

typedef RawHttpProgressCallback = void Function(int current, int? total);

abstract class RawHttpClient {
  factory RawHttpClient() => createClient();

  Future<StreamedResponse> send({
    required BaseRequest request,
    RawHttpCancelToken? cancelToken,
    RawHttpProgressCallback? onSendProgress,
    RawHttpProgressCallback? onReceiveProgress,
  });

  void close();
}

abstract class RawHttpCancelToken {
  factory RawHttpCancelToken() = _RawHttpCancelTokenImpl;

  bool get isCanceled;
  Stream<bool> get onCancel;
  void cancel();
}

final class _RawHttpCancelTokenImpl implements RawHttpCancelToken {
  bool _isCanceled = false;
  @override
  bool get isCanceled => _isCanceled;

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  @override
  Stream<bool> get onCancel => _controller.stream;

  @override
  void cancel() {
    if (isCanceled) return;
    _isCanceled = true;
    _controller.add(true);
    _controller.close();
  }
}

/// Returns whether [method] supports send and receive progress
/// callbacks respectively as a [Record] of two [bool]s.
///
/// Here are supported methods:
/// - `GET`: supports only receive progress callback.
/// - `POST`, `PUT`, `PATCH`: supports both send and receive progress callbacks.
/// - Others: supports neither send nor receive progress callbacks.
@internal
(bool, bool) getSupportedMethodProgressCallbacks(String method) => switch (method) {
      'GET' => (false, true),
      'POST' || 'PUT' || 'PATCH' => (true, true),
      _ => (false, false),
    };

extension ClientExceptionExtensions on ClientException {
  bool get isRequestCanceled => message == 'HTTP request canceled';
}
