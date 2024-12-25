// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:toku_flutter_common/core.dart' as _i611;
import 'package:toku_flutter_common/network.dart' as _i25;
import 'package:toku_flutter_common/src/core/core_dependency_provider.dart'
    as _i148;
import 'package:toku_flutter_common/src/core/utils/releasable_operation.dart'
    as _i851;
import 'package:toku_flutter_common/src/core/utils/string_validator.dart'
    as _i673;
import 'package:toku_flutter_common/src/network/http/_http.dart' as _i462;
import 'package:toku_flutter_common/src/network/interceptor/interceptors/connection_checker_interceptor.dart'
    as _i614;
import 'package:toku_flutter_common/src/network/interceptor/interceptors/failed_request_handler_interceptor.dart'
    as _i561;
import 'package:toku_flutter_common/src/network/network/connection_checker.dart'
    as _i540;
import 'package:toku_flutter_common/src/network/network/failed_request_handlers/_failed_request_handlers.dart'
    as _i660;
import 'package:toku_flutter_common/src/network/network/failed_request_handlers/connection_issue_handler.dart'
    as _i324;
import 'package:toku_flutter_common/src/network/network/network.dart' as _i148;
import 'package:toku_flutter_common/src/network/network_dependency_provider.dart'
    as _i54;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> initKartjisMobileCommonDependencies(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final networkDependencyProvider = _$NetworkDependencyProvider();
  final coreDependencyProvider = _$CoreDependencyProvider();
  gh.factory<_i673.StringValidator>(() => _i673.StringValidator());
  gh.factory<_i851.ReleasableOperation>(() => _i851.ReleasableOperation());
  gh.singleton<_i324.ConnectionIssueHandler>(
      () => _i324.ConnectionIssueHandler());
  gh.singleton<_i895.Connectivity>(
      () => networkDependencyProvider.provideConnectivity);
  gh.lazySingleton<_i148.Network>(() => const _i148.Network());
  gh.lazySingleton<_i25.Client>(() => networkDependencyProvider.provideClient);
  gh.lazySingleton<_i25.RawHttpClient>(
      () => networkDependencyProvider.provideDio);
  await gh.singletonAsync<_i25.ConnectionChecker>(
    () => networkDependencyProvider
        .provideConnectionChecker(gh<_i895.Connectivity>()),
    preResolve: true,
  );
  gh.factory<_i611.StringValidator>(
    () => coreDependencyProvider.provideOptionalStringValidator,
    instanceName: 'optionalStringValidator',
  );
  gh.factory<_i611.Debouncer>(
    () => coreDependencyProvider.provideDebouncer250ms,
    instanceName: 'debouncer250ms',
  );
  gh.singleton<_i614.ConnectionCheckerInterceptor>(
      () => _i614.ConnectionCheckerInterceptor(gh<_i540.ConnectionChecker>()));
  gh.factory<_i611.Debouncer>(
    () => coreDependencyProvider.provideDebouncer500ms,
    instanceName: 'debouncer500ms',
  );
  gh.singleton<_i25.FailedRequestHandlerRegistry>(() =>
      networkDependencyProvider.provideFailedRequestHandlerRegistry(
          gh<_i660.ConnectionIssueHandler>()));
  gh.singleton<_i561.FailedRequestHandlerInterceptor>(() =>
      _i561.FailedRequestHandlerInterceptor(
          gh<_i561.FailedRequestHandlerRegistry>()));
  gh.lazySingleton<_i462.HttpClient>(() => _i462.HttpClient(
        client: gh<_i462.Client>(),
        rawClient: gh<_i25.RawHttpClient>(),
        network: gh<_i25.Network>(),
        config: gh<_i462.HttpConfig>(),
        interceptorChainFactory: gh<_i25.InterceptorChainFactory>(),
      ));
  return getIt;
}

class _$NetworkDependencyProvider extends _i54.NetworkDependencyProvider {}

class _$CoreDependencyProvider extends _i148.CoreDependencyProvider {}
