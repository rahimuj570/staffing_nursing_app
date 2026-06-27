import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_colors.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Padding(
        padding: .symmetric(horizontal: 20.w),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemCount: 10,
          itemBuilder: (context, index) => Row(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(color: Colors.white, shape: .circle),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 26.r,
                  color: AppColors.themeColorLight,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
                      style: TextStyle(fontSize: 14.sp, fontWeight: .w600),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined, size: 16.r),
                        SizedBox(width: 4.w),
                        Text(
                          '5 minutes ago',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
