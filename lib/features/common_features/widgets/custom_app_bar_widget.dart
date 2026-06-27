import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';

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
              ? Image.asset(AppAssets.appBarLogo, height: 40.h)
              : Text(
                  title!,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, size: 26.r),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
