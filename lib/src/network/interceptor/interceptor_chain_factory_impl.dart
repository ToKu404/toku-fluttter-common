part of interceptor;

class _InterceptorChainFactoryImpl implements InterceptorChainFactory {
  const _InterceptorChainFactoryImpl(this._network, this._interceptors);

  final Network _network;
  final List<Interceptor> _interceptors;

  @override
  Future<Result<HttpResponse>> send({
    required HttpEndpointBase<dynamic> endpoint,
    required BaseRequest request,
    required Client client,
    required JsonMap requestBody
  }) {
    return _InterceptorChainImpl(
      network: _network,
      client: client,
      interceptors: _interceptors,
      endpoint: endpoint,
      request: request,
      requestBody: requestBody
    ).start();
  }
}
