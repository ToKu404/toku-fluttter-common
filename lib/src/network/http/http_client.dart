part of http;

@lazySingleton
abstract class HttpClient {
  @factoryMethod
  factory HttpClient({
    // We still need [Client] here since [RawHttpClient] is not
    // fully tested on app. So it's safer to use [Client] for general
    // API requests, and [RawHttpClient] for downloading files.
    required Client client,
    required RawHttpClient rawClient,
    required Network network,
    required HttpConfig config,
    required InterceptorChainFactory interceptorChainFactory,
  }) = _HttpClientImpl;

  @optionalTypeArgs
  Future<Result<T>> send<T>({
    required HttpEndpointBase<T> endpoint,
    required HttpRequest request,
  });

  /// Sends a GET request to the provided [url] and returns the response as a complete chunk
  /// of bytes.
  ///
  /// If the server response is other than 200, this will return
  /// [Result.error].
  ///
  /// This method uses [RawHttpClient] under the hood and should only be used
  /// to receive bytes from external urls (urls other than [HttpConfig.baseUrl]).
  ///
  /// This method also does not use the [InterceptorChain] to intercept
  /// both requests and responses.
  Future<Result<List<int>>> getBytes({
    required Uri url,
    RawHttpCancelToken? cancelToken,
    RawHttpProgressCallback? onReceiveProgress,
  });

  @visibleForTesting
  static String maybeReplaceVariablesInEndpoint({
    required String path,
    required Map<String, String>? variables,
  }) {
    if (variables?.isNotEmpty != true) return path;

    String endpointWithVariables = path;

    for (final variableKey in variables!.keys) {
      endpointWithVariables = endpointWithVariables.replaceAll(
        '{$variableKey}',
        variables[variableKey]!,
      );
    }

    return endpointWithVariables;
  }

  @optionalTypeArgs
  @visibleForTesting
  static Result<T> parseSuccessData<T>(
      HttpEndpointBase<T> endpoint, HttpResponse response) {
    try {
      final result = endpoint.onResponse(response);
      if (result is T) {
        return Result<T>.success(result);
      } else {
        return Result.error(
            HttpException(result, statusCode: response.statusCode));
      }
    } on FormatException {
      return Result.error(BadResponseFormatException());
    } on BadResponseFormatException {
      return Result.error(BadResponseFormatException());
      // ignore: avoid_catching_errors
    } on TypeError {
      return Result.error(UnexpectedResponseFormatException());
    } catch (e, st) {
      log(
        'Unknown error while parsing response',
        name: 'HttpClient.parseSuccessData',
        error: e,
        stackTrace: st,
      );
      return Result.error(UnknownErrorException());
    }
  }
}
