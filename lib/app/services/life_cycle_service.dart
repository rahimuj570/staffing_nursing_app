import 'package:flutter/widgets.dart';

class LifecycleService with WidgetsBindingObserver {
  LifecycleService._() {
    WidgetsBinding.instance.addObserver(this);
  }

  static final LifecycleService instance = LifecycleService._();

  bool _isForeground = true;

  bool get isForeground => _isForeground;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _isForeground = state == AppLifecycleState.resumed;
  }
}
