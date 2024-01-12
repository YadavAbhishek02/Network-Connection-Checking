import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  late StreamController<bool> _internetStatusController;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Stream<bool> get internetStatusStream => _internetStatusController.stream;

  ConnectivityUtil() {
    _internetStatusController = StreamController<bool>.broadcast();
    _checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      _handleConnectivityChange(result);
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _handleConnectivityChange(connectivityResult);
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    _internetStatusController.add(result != ConnectivityResult.none);
  }

  void dispose() {
    _connectivitySubscription.cancel();
    _internetStatusController.close();
  }
}
