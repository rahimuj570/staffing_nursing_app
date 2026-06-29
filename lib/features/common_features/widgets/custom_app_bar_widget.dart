import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/views/notification_view.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  const CustomAppBarWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20.0.w),
      child: Row(
        children: [
          title == null
              ? Image.asset(AppAssets.appBarLogo, width: 73.w)
              : Text(
                  title!,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.themeColorLight,
                  ),
                ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, size: 26.r),
            onPressed: () {
              context.push(NotificationView());
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
