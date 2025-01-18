part of http;

class _HttpClientImpl implements HttpClient {
  _HttpClientImpl({
    required this.client,
    required this.rawClient,
    required this.network,
    required this.config,
    required this.interceptorChainFactory,
  });

  final Network network;
  final HttpConfig config;
  final InterceptorChainFactory interceptorChainFactory;

  final Client client;
  final RawHttpClient rawClient;

  @override
  Future<Result<T>> send<T>({
    required HttpEndpointBase<T> endpoint,
    required HttpRequest request,
  }) async {
    final path = HttpClient.maybeReplaceVariablesInEndpoint(
      path: endpoint.path,
      variables: request.queryVariables,
    );

    final uri = config.baseUrl.replace(
      path: config.baseUrl.path + path,
      queryParameters: request.queryParameters,
    );

    final httpRequest = await _createBaseRequest(uri, endpoint, request);
    final requestBody = await _createRequestBody(request);

    final response = await interceptorChainFactory.send(
      endpoint: endpoint,
      request: httpRequest,
      client: client,
      requestBody: requestBody,
    );

    return response.andThen(
        (HttpResponse data) => HttpClient.parseSuccessData(endpoint, data));
  }

  FutureOr<JsonMap> _createRequestBody(HttpRequest request) {
    return request.body.when<JsonMap>(
      basic: (body) => body ?? <String, dynamic>{},
      multipart: (fields, files) => <String, dynamic>{},
    );
  }

  FutureOr<BaseRequest> _createBaseRequest(
      Uri uri, HttpEndpointBase<dynamic> endpoint, HttpRequest request) {
    return request.body.when<FutureOr<BaseRequest>>(
      basic: (Map<String, dynamic>? body) => network.createRequest(
        method: endpoint.method._value,
        url: uri,
        headers: _concatHeaders(request.contentType, request.headers),
        body: body,
      ),
      multipart: (Map<String, String>? fields, Map<String, XFile>? files) =>
          network.createMultipartRequest(
        method: endpoint.method._value,
        url: uri,
        headers: _concatHeaders(request.contentType, request.headers),
        fields: fields,
        files: files,
      ),
    );
  }

  Map<String, String> _concatHeaders(
      HttpContentType? contentType, Map<String, String>? other) {
    if (other == null) {
      if (contentType != null) {
        return <String, String>{
          ...config.defaultHeaders,
          'Content-Type': contentType._headerValue,
        };
      }
      return config.defaultHeaders;
    }
    return <String, String>{
      ...config.defaultHeaders,
      ...other,
    };
  }

  @override
  Future<Result<List<int>>> getBytes({
    required Uri url,
    RawHttpCancelToken? cancelToken,
    RawHttpProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await rawClient.send(
        request: Request('GET', url),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != 200) {
        return Result.error(ErrorResponseException(
          statusCode: response.statusCode,
          errorResponse: ErrorResponse(message: response.reasonPhrase ?? ''),
        ));
      }
      final body = await response.stream.toBytes();
      return Result.success(body);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e, st) {
      log(
        'Unknown error while getting bytes using Dio',
        name: 'HttpClient.getBytes',
        error: e,
        stackTrace: st,
      );
      return Result.error(UnknownErrorException(e));
    }
  }
}
