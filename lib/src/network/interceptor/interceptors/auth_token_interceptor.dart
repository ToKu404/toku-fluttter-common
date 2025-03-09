import 'package:toku_flutter_common/core.dart';
import 'package:toku_flutter_common/src/network/http/_http.dart';
import 'package:toku_flutter_common/src/network/interceptor/_interceptor.dart';

@lazySingleton
class AuthTokenInterceptor extends Interceptor {
  @override
  bool canIntercept(HttpEndpointBase endpoint, BaseRequest request) {
    if (endpoint.authType == AuthType.none) return false;
    if (endpoint.authType == AuthType.session && (accessToken == null || accessToken!.isEmpty)) {
      return false;
    }
    return true;
  }

  @override
  Future<Result<HttpResponse>> intercept(InterceptorChain chain) {
    switch (chain.endpoint.authType) {
      case AuthType.session:
        chain.request.headers['Authorization'] = 'Bearer $accessToken';
        break;
      case AuthType.basic:
        chain.request.headers['Authorization'] = '$basicToken';
        break;
      case AuthType.none:
        break;
    }
    return chain.proceed(chain.request);
  }

  String? basicToken;

  String? accessToken;
}
