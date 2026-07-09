import 'package:flutter/material.dart';

Color getSnackBarColor(MessageType type) {
  switch (type) {
    case MessageType.success:
      return Colors.green;
    case MessageType.error:
      return Colors.red;
    case MessageType.info:
      return const Color.fromARGB(255, 56, 96, 155);
    case MessageType.warning:
      return const Color.fromARGB(255, 173, 156, 0);
  }
}

void showStatusSnackbar(
  BuildContext context, {
  required String message,
  MessageType type = .success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: getSnackBarColor(type)),
  );
}

enum MessageType { success, error, info, warning }
