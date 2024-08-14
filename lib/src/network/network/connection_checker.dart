import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';


abstract class ConnectionChecker {
  factory ConnectionChecker(
    Connectivity connectivity,
    ConnectivityResult lastConnectivityResult,
  ) = _ConnectionCheckerImpl;

  bool get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class _ConnectionCheckerImpl implements ConnectionChecker {
  _ConnectionCheckerImpl(this._connectivity, this._lastConnectivityResult) {
    _subscribeConnectivity();
  }

  final Connectivity _connectivity;

  ConnectivityResult _lastConnectivityResult;

  @override
  bool get isConnected => isResultConnected(_lastConnectivityResult);

  @override
  Stream<bool> get onConnectivityChanged => _connectivity.onConnectivityChanged.map(isResultConnected);

  @visibleForTesting
  static bool isResultConnected(ConnectivityResult result) {
    return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
  }

  void _subscribeConnectivity() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) => _lastConnectivityResult = result);
  }
}
