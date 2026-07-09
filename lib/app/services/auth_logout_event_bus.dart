import 'dart:async';

class AuthLogoutEventBus {
  AuthLogoutEventBus._();

  static final AuthLogoutEventBus instance = AuthLogoutEventBus._();

  final StreamController<void> _logoutController =
      StreamController<void>.broadcast();

  Stream<void> get stream => _logoutController.stream;

  void logout() {
    _logoutController.add(null);
  }

  void dispose() {
    _logoutController.close();
  }
}
