import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatricTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const MatricTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20.r),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: .w500,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: .w700,
          ),
        ),
      ],
    );
  }
}
