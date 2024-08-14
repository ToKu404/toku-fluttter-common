part of interceptor;

class _InterceptorChainImpl implements InterceptorChain {
  _InterceptorChainImpl({
    int index = -1,
    required this.network,
    required this.client,
    required this.interceptors,
    required this.endpoint,
    required this.request,
    required this.requestBody,
  }) : _index = index;

  int _index;

  final Network network;

  final Client client;

  final List<Interceptor> interceptors;

  @override
  final HttpEndpointBase<dynamic> endpoint;

  @override
  final BaseRequest request;

  @override
  final JsonMap requestBody;

  int get _availableInterceptorIndex {
    for (var i = _index + 1; i < interceptors.length; i++) {
      final current = interceptors[i];
      if (current.canIntercept(endpoint, request)) return i;
    }
    return -1;
  }

  @protected
  Future<Result<HttpResponse>> start() {
    final availableInterceptorIndex = _availableInterceptorIndex;
    if (availableInterceptorIndex == -1) return sendRequest();
    _index = availableInterceptorIndex;
    final interceptor = interceptors[_index];
    return interceptor.intercept(this);
  }

  @override
  Future<Result<HttpResponse>> proceed(BaseRequest request) {
    final nextIndex = _availableInterceptorIndex;
    if (nextIndex == -1) {
      return _copyWith(
        index: _index,
        request: request,
      ).sendRequest();
    }
    final InterceptorChain nextChain = _copyWith(
      index: nextIndex,
      request: request,
    );
    final interceptor = interceptors[nextIndex];
    return interceptor.intercept(nextChain);
  }

  @protected
  Future<Result<HttpResponse>> sendRequest() async {
    try {
      final streamedResponse = await client.send(request.copy());
      final response = await network.getResponseFromStream(streamedResponse);
      return Result<HttpResponse>.success(response);
    } on Exception catch (e) {
      return Result<HttpResponse>.error(e);
    }
  }

  _InterceptorChainImpl _copyWith({
    required int index,
    required BaseRequest request,
  }) {
    return _InterceptorChainImpl(
      index: index,
      network: network,
      client: client,
      interceptors: interceptors,
      endpoint: endpoint,
      request: request,
      requestBody: requestBody,
    );
  }
}
