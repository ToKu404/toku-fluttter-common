
import 'package:injectable/injectable.dart';
import 'package:kartjis_mobile_common/src/network/http/_http.dart';
import 'package:kartjis_mobile_common/src/network/interceptor/_interceptor.dart';

@InjectableInit(
  initializerName: 'initKartjisMobileCommonDependencies',
  generateForDir: <String>['lib/src'],
  asExtension: false,
  includeMicroPackages: false,
  ignoreUnregisteredTypes: [HttpConfig, InterceptorChainFactory]
)
// This is deliberately a private method to trigger the code generation
// ignore: unused_element
void _init() {}
