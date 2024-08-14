part of interceptor;

abstract class Interceptor {
  const Interceptor();

  bool canIntercept(HttpEndpointBase<dynamic> endpoint, BaseRequest request) => true;

  Future<Result<HttpResponse>> intercept(InterceptorChain chain);
}
