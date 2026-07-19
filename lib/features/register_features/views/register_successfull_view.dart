import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/home_main_nav_holder_features/views/home_main_nav_holder_view.dart';

class RegisterSuccessfullView extends StatelessWidget {
  const RegisterSuccessfullView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 16.h),
                Center(
                  child: Image.asset(AppAssets.logoTransparemt, width: 182.w),
                ),
                SizedBox(height: 58.h),
                Center(child: Image.asset(AppAssets.sandTime)),
                SizedBox(height: 10.h),
                Text(
                  'LAC Staffing is reviewing your documents. Please check back later and keep an eye on your email for updates.',
                  style: TextStyle(fontSize: 20.sp, fontWeight: .w500),
                  textAlign: .center,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.themeColor,
                      size: 30.r,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Account Created',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: .w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.themeColor,
                      size: 30.r,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Documents Submitted',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: .w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(
                      Icons.av_timer_rounded,
                      color: AppColors.themeColor,
                      size: 30.r,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Verification In Progress',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: .w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
                customElevatedButtonWidget(
                  text: 'Refresh',
                  onTapped: () {
                    context.pushRemoveUntil(HomeMainNavHolderView());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
