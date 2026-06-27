import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';

class CustomDropdownFieldWidget extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownFieldWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1F2937), // Dark slate/charcoal text color
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,

      // Matching the dropdown icon exactly
      icon: Icon(
        RemixIcons.arrow_down_s_line,
        color: AppColors.themeColor,
        size: 24.r,
      ),

      // Floating Dropdown Panel Box Customization
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      elevation: 3,

      // Floating Input Decoration Elements
      decoration: InputDecoration(
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.themeColor.withValues(alpha: 0.6),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.themeColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior
            .always, // Ensures the layout matches your mockup structure
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),

        // Match the rounded gray border outline
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.themeColor.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.themeColor, width: 1.5),
        ),
        // backgroundFilled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
