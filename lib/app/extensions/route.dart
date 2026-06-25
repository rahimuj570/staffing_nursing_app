import 'package:flutter/material.dart';

extension RouteExtension on BuildContext {
  void push(Widget widget) =>
      Navigator.push(this, MaterialPageRoute(builder: (context) => widget));

  void pushReplacement(Widget widget) => Navigator.pushReplacement(
    this,
    MaterialPageRoute(builder: (context) => widget),
  );

  void pop() => Navigator.pop(this);

  void pushRemoveUntil(Widget widget) => Navigator.pushAndRemoveUntil(
    this,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}
