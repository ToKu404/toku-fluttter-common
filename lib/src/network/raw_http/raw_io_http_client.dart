import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kartjis_mobile_common/src/core/extensions/object_extensions.dart';
import 'package:kartjis_mobile_common/src/core/extensions/stream_extensions.dart';
import 'package:kartjis_mobile_common/src/network/raw_http/raw_http_client.dart';



RawHttpClient createClient() => RawIOHttpClient();

final class RawIOHttpClient implements RawHttpClient {
  RawIOHttpClient([HttpClient? inner]) : _inner = inner ?? HttpClient();

  /// The underlying `dart:io` HTTP client.
  HttpClient? _inner;

  @override
  Future<StreamedResponse> send({
    required BaseRequest request,
    RawHttpCancelToken? cancelToken,
    RawHttpProgressCallback? onSendProgress,
    RawHttpProgressCallback? onReceiveProgress,
  }) async {
    if (_inner == null) {
      throw ClientException('HTTP request failed. Client is already closed.', request.url);
    }

    final stream = request.finalize();
    final (supportsSendCallback, supportsReceiveCallback) = getSupportedMethodProgressCallbacks(request.method);

    try {
      final ioRequest = (await _inner!.openUrl(request.method, request.url))
        ..followRedirects = request.followRedirects
        ..maxRedirects = request.maxRedirects
        ..contentLength = (request.contentLength ?? -1)
        ..persistentConnection = request.persistentConnection;
      request.headers.forEach((name, value) {
        ioRequest.headers.set(name, value);
      });

      StreamSubscription<bool>? cancelTokenSubscription;
      void cancelSubscription() {
        cancelTokenSubscription?.cancel();
        cancelTokenSubscription = null;
      }

      void createSubscription() {
        cancelTokenSubscription = cancelToken?.onCancel.listen((isCanceled) {
          if (isCanceled) ioRequest.abort();
          cancelSubscription();
        });
      }

      createSubscription();

      final HttpClientResponse response;
      if (cancelToken != null) {
        stream.where((_) => !cancelToken.isCanceled).listen((data) {
          if (supportsSendCallback && onSendProgress != null) {
            onSendProgress(data.length, request.contentLength);
          }
          ioRequest.add(data);
        });
        if (cancelToken.isCanceled) {
          throw ClientException('HTTP request canceled', request.url);
        }
        response = await ioRequest.close();
      } else {
        response = await stream.pipe(ioRequest) as HttpClientResponse;
      }

      cancelSubscription();

      final headers = <String, String>{};
      response.headers.forEach((key, values) {
        headers[key] = values.join(',');
      });

      Stream<List<int>> maybeCountReceiveProgress(Stream<List<int>> source) {
        if (supportsReceiveCallback && onReceiveProgress != null) {
          return source.count((count, data) {
            final cnt = count + data.length;
            onReceiveProgress(cnt, response.contentLength == -1 ? null : response.contentLength);
            return cnt;
          });
        }
        return source;
      }

      return StreamedResponse(
        response.handleError((Object error) {
          final httpException = error as HttpException;
          throw ClientException(httpException.message, httpException.uri);
        }, test: (error) => error is HttpException).let(maybeCountReceiveProgress),
        response.statusCode,
        contentLength: response.contentLength == -1 ? null : response.contentLength,
        request: request,
        headers: headers,
        isRedirect: response.isRedirect,
        persistentConnection: response.persistentConnection,
        reasonPhrase: response.reasonPhrase,
      );
    } on SocketException catch (error) {
      throw ClientException(error.message, request.url);
    } on HttpException catch (error) {
      throw ClientException(error.message, error.uri);
    }
  }

  @override
  void close() {
    if (_inner == null) return;
    _inner!.close(force: true);
    _inner = null;
  }
}
