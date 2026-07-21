import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService {
  NetworkService._();

  static final instance = NetworkService._();

  Future<void> Function()? onRetry;

  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _controller.stream;

  StreamSubscription? _subscription;

  void initialize() {
    _subscription ??= Connectivity().onConnectivityChanged.listen((_) async {
      final hasInternet = await InternetConnection().hasInternetAccess;

      _controller.add(hasInternet);
    });

    checkConnection();
  }

  Future<bool> checkConnection() async {
    final hasInternet = await InternetConnection().hasInternetAccess;

    _controller.add(hasInternet);

    return hasInternet;
  }

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
