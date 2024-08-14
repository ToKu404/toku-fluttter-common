import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:kartjis_mobile_common/network.dart';
import 'package:kartjis_mobile_common/src/core/anotations/_annotations.dart';
import 'package:kartjis_mobile_common/src/network/network/failed_request_handlers/_failed_request_handlers.dart';

@internal
@module
abstract class NetworkDependencyProvider {
  @singleton
  Connectivity get provideConnectivity => Connectivity();

  @singleton
  @preResolve
  Future<ConnectionChecker> provideConnectionChecker(
    Connectivity connectivity,
  ) async {
    return ConnectionChecker(
      connectivity,
      await connectivity.checkConnectivity(),
    );
  }

  @lazySingleton
  Client get provideClient => Client();

  @lazySingleton
  RawHttpClient get provideDio => RawHttpClient();

  @singleton
  FailedRequestHandlerRegistry provideFailedRequestHandlerRegistry(
    ConnectionIssueHandler connectionIssueHandler,
  ) {
    return FailedRequestHandlerRegistry()
      ..addHandlers([
        connectionIssueHandler,
      ]);
  }
}
