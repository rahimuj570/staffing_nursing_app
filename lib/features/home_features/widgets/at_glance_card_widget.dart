import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

class AtGlanceCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const AtGlanceCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColors.themeColorDark, AppColors.themeColorLight],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.white,
                fontWeight: .w600,
              ),
            ),
            Text(
              subtitle,
              textAlign: .center,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: .w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
