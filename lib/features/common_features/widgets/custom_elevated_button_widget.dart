import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

Widget customElevatedButtonWidget({
  required String text,
  required VoidCallback? onTapped,
  Color? backgroundColor,
  Color? forgroundColor,
  Color? borderColor,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.themeColor,
      foregroundColor: forgroundColor ?? Colors.white,
      minimumSize: Size(double.infinity, 48.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
    ),
    onPressed: onTapped,
    child: Text(
      text,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
    ),
  );
}
