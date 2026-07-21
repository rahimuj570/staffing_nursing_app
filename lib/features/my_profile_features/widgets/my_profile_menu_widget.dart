import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

class MytProfileMenuWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const MytProfileMenuWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: .center,
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              shape: .circle,
              color: AppColors.greyLight,
            ),
            child: Icon(icon, size: 20.r, color: AppColors.themeColorLight),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: .w500),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 20.r),
        ],
      ),
    );
  }
}
