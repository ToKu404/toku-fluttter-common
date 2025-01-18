import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:toku_flutter_common/src/core/extensions/completor_extension.dart';
import 'package:toku_flutter_common/src/network/raw_http/raw_http_client.dart';


RawHttpClient createClient() => RawBrowserHttpClient();

final class RawBrowserHttpClient implements RawHttpClient {
  /// The currently active XHRs.
  ///
  /// These are aborted if the client is closed.
  final _xhrs = <HttpRequest>{};

  /// Whether to send credentials such as cookies or authorization headers for
  /// cross-site requests.
  ///
  /// Defaults to `false`.
  bool withCredentials = false;

  bool _isClosed = false;

  @override
  Future<StreamedResponse> send({
    required BaseRequest request,
    RawHttpCancelToken? cancelToken,
    RawHttpProgressCallback? onSendProgress,
    RawHttpProgressCallback? onReceiveProgress,
  }) async {
    if (_isClosed) {
      throw ClientException('HTTP request failed. Client is already closed.', request.url);
    }
    final bytes = await request.finalize().toBytes();
    final (supportsSendCallback, supportsReceiveCallback) = getSupportedMethodProgressCallbacks(request.method);
    final xhr = HttpRequest();
    _xhrs.add(xhr);
    xhr
      ..open(request.method, '${request.url}', async: true)
      ..responseType = 'arraybuffer'
      ..withCredentials = withCredentials;
    request.headers.forEach(xhr.setRequestHeader);

    final completer = Completer<StreamedResponse>();

    xhr.onLoad.first.then((_) {
      final body = (xhr.response as ByteBuffer).asUint8List();
      completer.maybeComplete(StreamedResponse(
        ByteStream.fromBytes(body),
        xhr.status!,
        contentLength: body.length,
        request: request,
        headers: xhr.responseHeaders,
        reasonPhrase: xhr.statusText,
      ));
    });

    xhr.onError.first.then((_) {
      // Unfortunately, the underlying XMLHttpRequest API doesn't expose any
      // specific information about the error itself.
      completer.maybeCompleteError(
        ClientException('XMLHttpRequest error.', request.url),
        StackTrace.current,
      );
    });

    xhr.onAbort.first.then((_) {
      completer.maybeCompleteError(ClientException(
        'HTTP request canceled',
        request.url,
      ));
    });

    StreamSubscription? receiveProgressSubscription;
    if (supportsReceiveCallback && onReceiveProgress != null) {
      receiveProgressSubscription = xhr.onProgress.listen((event) {
        if (event.lengthComputable) {
          onReceiveProgress(event.loaded!, event.total);
        }
      });
    }

    StreamSubscription? sendProgressSubscription;
    if (supportsSendCallback && onSendProgress != null) {
      sendProgressSubscription = xhr.upload.onProgress.listen((event) {
        if (event.lengthComputable) {
          onSendProgress(event.loaded!, event.total);
        }
      });
    }

    StreamSubscription? cancelTokenSubscription;
    if (cancelToken != null) {
      cancelTokenSubscription = cancelToken.onCancel.listen((isCanceled) {
        if (isCanceled) xhr.abort();
        cancelTokenSubscription?.cancel();
        cancelTokenSubscription = null;
      });
    }

    xhr.send(bytes);

    try {
      return await completer.future;
    } finally {
      receiveProgressSubscription?.cancel();
      sendProgressSubscription?.cancel();
      cancelTokenSubscription?.cancel();
      _xhrs.remove(xhr);
    }
  }

  /// Closes the client.
  ///
  /// This terminates all active requests.
  @override
  void close() {
    _isClosed = true;
    for (final xhr in _xhrs) {
      xhr.abort();
    }
    _xhrs.clear();
  }
}
