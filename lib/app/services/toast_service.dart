import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:staffing/app/services/life_cycle_service.dart';

class ToastService {
  ToastService._();

  static void showError(String message) {
    if (!LifecycleService.instance.isForeground) return;

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}
