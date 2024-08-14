part of interceptor;

abstract class InterceptorChain {
  factory InterceptorChain({
    int index,
    required Network network,
    required Client client,
    required List<Interceptor> interceptors,
    required HttpEndpointBase<dynamic> endpoint,
    required BaseRequest request,
    required JsonMap requestBody,
  }) = _InterceptorChainImpl;

  HttpEndpointBase<dynamic> get endpoint;
  BaseRequest get request;
  JsonMap get requestBody;
  Future<Result<HttpResponse>> proceed(BaseRequest request);
}
