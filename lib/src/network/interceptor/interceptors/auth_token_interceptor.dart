import 'package:kartjis_mobile_common/src/core/models/result.dart';
import 'package:kartjis_mobile_common/src/network/http/_http.dart';
import 'package:kartjis_mobile_common/src/network/interceptor/_interceptor.dart';

abstract class AuthTokenInterceptor extends Interceptor {
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
        final body = chain.requestBody;
        final basicToken = getBasicToken(body['username'], body['password']);
        if (basicToken != null) {
          chain.request.headers['Authorization'] = basicToken;
        }
        break;
      case AuthType.none:
        break;
    }
    return chain.proceed(chain.request);
  }

  String? getBasicToken(String username, String password);

  String? accessToken;
}
