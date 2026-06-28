import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

class MyProfileInfoCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const MyProfileInfoCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            spacing: 4.h,
            children: [
              Icon(icon, size: 24.r),
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: .w600),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: .w400,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
