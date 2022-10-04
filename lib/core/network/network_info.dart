import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectionChecker;
  NetworkInfoImpl(this._connectionChecker);
  @override
  Future<ConnectivityResult> get isConnected => _connectionChecker.checkConnectivity();
}
