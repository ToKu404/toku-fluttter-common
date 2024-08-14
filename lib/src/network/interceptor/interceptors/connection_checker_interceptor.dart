
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:kartjis_mobile_common/src/core/models/result.dart';
import 'package:kartjis_mobile_common/src/network/exceptions/exceptions.dart';
import 'package:kartjis_mobile_common/src/network/http/_http.dart';
import 'package:kartjis_mobile_common/src/network/interceptor/_interceptor.dart';
import 'package:kartjis_mobile_common/src/network/network/connection_checker.dart';

const List<String> _connectionIssueErrorMessages = [
  'failed host lookup',
  'connection failed',
];

bool _isClientExceptionWithConnectionIssue(ClientException exception) {
  final message = exception.message.toLowerCase();
  return _connectionIssueErrorMessages.any(message.contains);
}

@singleton
class ConnectionCheckerInterceptor extends Interceptor {
  const ConnectionCheckerInterceptor(this._connectionChecker);

  final ConnectionChecker _connectionChecker;

  @override
  Future<Result<HttpResponse>> intercept(InterceptorChain chain) {
    if (!_connectionChecker.isConnected) return Future.value(Result.error(NoConnectionException()));
    return chain.proceed(chain.request).mapErrorAsync((error) =>
        error is ClientException && _isClientExceptionWithConnectionIssue(error) ? NoConnectionException() : error);
  }
}
