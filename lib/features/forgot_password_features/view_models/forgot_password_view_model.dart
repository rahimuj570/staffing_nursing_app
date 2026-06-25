import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  bool passwordObsecure = true;

  void changePasswordObsecure() {
    passwordObsecure = !passwordObsecure;
    notifyListeners();
  }

  bool confirmPasswordObsecure = true;

  void changeConfirmPasswordObsecure() {
    confirmPasswordObsecure = !confirmPasswordObsecure;
    notifyListeners();
  }
}
