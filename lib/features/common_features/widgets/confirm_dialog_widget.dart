import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:staffing/app/constants/app_colors.dart';

class ConfirmDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String confirmText;
  final String cancelText;

  ConfirmDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: _titleTextStyle),
      content: Text(message, style: _contentTextStyle),
      actions: <Widget>[
        TextButton(
          child: Text(cancelText, style: _buttonTextStyle),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(confirmText, style: _buttonTextStyle),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
      backgroundColor: AppColors.greyLight,
      titleTextStyle: _titleTextStyle,
      contentTextStyle: _contentTextStyle,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  final TextStyle _titleTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.themeColor,
  );

  final TextStyle _contentTextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.themeColor,
  );

  final TextStyle _buttonTextStyle = TextStyle(
    fontSize: 16.sp,
    color: AppColors.themeColor,
  );
}
