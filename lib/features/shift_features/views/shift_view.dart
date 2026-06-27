import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/common_features/widgets/shift_card_widget.dart';
import 'package:staffing/features/shift_features/views/filter_shift_view.dart';

class ShiftView extends StatelessWidget {
  const ShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEC = TextEditingController();
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Shifts'),
      body: Padding(
        padding: .symmetric(horizontal: 20.0.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: customTextFieldWidget(
                    prefixIcon: RemixIcons.search_2_line,
                    label: '',
                    controller: searchTEC,
                    textInputType: .text,
                    placeHolder: 'Search...',
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => context.push(FilterShiftView()),
                  child: Container(
                    height: 46.h,
                    width: 46.w,
                    decoration: BoxDecoration(
                      color: AppColors.themeColorLight,
                      borderRadius: .circular(12.r),
                    ),
                    child: Icon(
                      Remix.filter_line,
                      size: 20.r,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: 10,
                itemBuilder: (context, index) => ShiftCardWidget(
                  title: 'Sunrise Care Center',
                  location: 'Atlanta, GA',
                  date: 'May 20, 2026',
                  time: '7:00 AM - 3:00 PM',
                  status: 'RN',
                  ratePerHour: '58',
                  image: AppAssets.hospitalImage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
