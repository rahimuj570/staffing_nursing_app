import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/features/common_features/views/shift_details_view.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';

class ShiftConfirmationView extends StatelessWidget {
  const ShiftConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shift Confirmation')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 84.h),
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    shape: .circle,
                    border: .all(color: AppColors.themeColorLight, width: 2),
                  ),
                  child: Icon(
                    Icons.question_mark_outlined,
                    size: 50.r,
                    color: AppColors.themeColorLight,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Confirm Shift Pickup',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: .w700,
                    color: AppColors.themeColorLight,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Are you sure you want to accept this shift?',
                  style: TextStyle(fontSize: 14.sp, fontWeight: .w400),
                ),
                SizedBox(height: 20.h),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: .symmetric(horizontal: 12.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        ListView.custom(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childrenDelegate: SliverChildListDelegate.fixed([
                            ShiftInformationTileWidget(
                              icon: RemixIcons.community_line,
                              title: 'Facility Name',
                              subtitle: 'Sunrise Care Center',
                            ),
                            ShiftInformationTileWidget(
                              icon: RemixIcons.calendar_2_line,
                              title: 'Date',
                              subtitle: 'July 15, 2026',
                            ),
                            ShiftInformationTileWidget(
                              icon: RemixIcons.timer_2_line,
                              title: 'Time',
                              subtitle: '7:00 AM – 3:00 PM',
                            ),
                            ShiftInformationTileWidget(
                              icon: Icons.attach_money_outlined,
                              title: 'Pay Rate',
                              subtitle: '\$42/hr',
                            ),
                            ShiftInformationTileWidget(
                              hideDivider: true,
                              icon: RemixIcons.map_pin_2_line,
                              title: 'Distance',
                              subtitle: '2.4 Miles Away',
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: .symmetric(horizontal: 20.0.w),
          child: Column(
            mainAxisSize: .min,
            children: [
              customElevatedButtonWidget(
                text: 'Confirm Shift',
                onTapped: () {},
              ),
              SizedBox(height: 16.h),
              customElevatedButtonWidget(
                borderColor: AppColors.themeColor,
                backgroundColor: Colors.white,
                forgroundColor: AppColors.themeColor,
                text: 'Cancel',
                onTapped: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
