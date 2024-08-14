part of interceptor;

abstract class InterceptorChainFactory {
  const factory InterceptorChainFactory(
    Network network,
    List<Interceptor> interceptors,
  ) = _InterceptorChainFactoryImpl;

  Future<Result<HttpResponse>> send({
    required HttpEndpointBase<dynamic> endpoint,
    required BaseRequest request,
    required Client client,
    required JsonMap requestBody,
  });
}
