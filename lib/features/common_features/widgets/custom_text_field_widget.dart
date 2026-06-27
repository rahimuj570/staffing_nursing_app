import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

Widget customTextFieldWidget({
  required String label,
  required TextEditingController controller,
  required TextInputType textInputType,
  required String placeHolder,
  bool readOnly = false,
  bool obscureText = false,
  IconData? suffixIcon,
  IconData? prefixIcon,
  String? Function(String?)? validator,
  VoidCallback? onSuffixTap,
}) {
  return Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    children: [
      if (label.isNotEmpty)
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: .w600,
            color: Colors.black,
          ),
        ),
      if (label.isNotEmpty) SizedBox(height: 4.h),
      TextFormField(
        readOnly: readOnly,
        obscureText: obscureText,
        keyboardType: .emailAddress,
        validator: validator,
        autovalidateMode: .onUserInteraction,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 16.sp, fontWeight: .w400),
          hintText: placeHolder,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
          suffixIcon: suffixIcon == null
              ? null
              : GestureDetector(onTap: onSuffixTap, child: Icon(suffixIcon)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.themeColor, width: 1.5.r),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.themeColor, width: 2.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.themeColor, width: 1.5.r),
          ),
        ),
      ),
    ],
  );
}
