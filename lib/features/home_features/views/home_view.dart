import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/views/shift_details_view.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
import 'package:staffing/features/home_features/widgets/at_glance_card_widget.dart';
import 'package:staffing/features/home_features/widgets/matric_tile_widget.dart';
import 'package:staffing/features/home_features/widgets/next_shift_card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: .symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Tuesday, June 16, 2026',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: .w400,
                            color: AppColors.greyColor,
                          ),
                        ),
                        Text(
                          'Good Morning, Shanae',
                          style: TextStyle(fontSize: 20.sp, fontWeight: .w600),
                        ),
                        Text(
                          'Ready for another great day of care?',
                          style: TextStyle(fontSize: 12.sp, fontWeight: .w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 72.h,
                    width: 72.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greyColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(AppAssets.nurseDp, fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                padding: .all(10.r),
                // height: 120.h,
                width: 1.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.themeColor,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.themeColorLight,
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.star, color: Colors.amber, size: 40),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'Your LAC Score',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: .w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: .w600,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16.r),
                            Icon(Icons.star, color: Colors.amber, size: 16.r),
                            Icon(Icons.star, color: Colors.amber, size: 16.r),
                            Icon(Icons.star, color: Colors.amber, size: 16.r),
                            Icon(Icons.star, color: Colors.amber, size: 16.r),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Excellent',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: .w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: .symmetric(horizontal: 15.w),
                      child: Container(
                        width: 1,
                        height: 80.h,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 6.h,
                        children: [
                          MatricTileWidget(
                            icon: RemixIcons.shield_check_line,
                            title: 'Reliability',
                            value: '98%',
                          ),
                          MatricTileWidget(
                            icon: RemixIcons.time_line,
                            title: 'Punctuality',
                            value: '97%',
                          ),
                          MatricTileWidget(
                            icon: RemixIcons.user_3_line,
                            title: 'Performance',
                            value: '4.8/5',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Your Next Shift',
                style: TextStyle(fontSize: 16.sp, fontWeight: .w500),
              ),
              SizedBox(height: 8.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => SizedBox(height: 4.h),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => context.push(const ShiftDetailsView()),
                  child: NextShiftCardWidget(),
                ),
              ),

              SizedBox(height: 20.h),
              Text(
                'At a Glance',
                style: TextStyle(fontSize: 16.sp, fontWeight: .w500),
              ),
              SizedBox(height: 8.h),
              GridView.custom(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                ),
                childrenDelegate: SliverChildListDelegate([
                  AtGlanceCardWidget(title: '5', subtitle: 'Upcoming Shift'),
                  AtGlanceCardWidget(
                    title: '\$1256',
                    subtitle: 'Earnings This Week',
                  ),
                  AtGlanceCardWidget(
                    title: '5',
                    subtitle: 'Documents Expiring Soon',
                  ),
                  AtGlanceCardWidget(
                    title: 'Compliant',
                    subtitle: 'All Requirements Up to Date',
                  ),
                ]),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
