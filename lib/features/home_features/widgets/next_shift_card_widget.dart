import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/utils/format_date_util.dart';
import 'package:staffing/app/utils/format_time_util.dart';

class NextShiftCardWidget extends StatelessWidget {
  final String? facilityName;
  final String? facilityCity;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? status;
  final String? profession;
  final String? facilityImage;
  const NextShiftCardWidget({
    super.key,
    required this.facilityName,
    required this.facilityCity,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.profession,
    required this.facilityImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: .all(8.r),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Container(
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(AppAssets.hospitalImage, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          facilityName ?? 'N/A',
                          style: TextStyle(fontSize: 14.sp, fontWeight: .w700),
                        ),
                      ),

                      Container(
                        padding: .all(4.r),
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          status ?? 'N/A',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: .w500,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.r,
                        color: AppColors.gold,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        facilityCity ?? 'N/A',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: .w600,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  Row(
                    children: [
                      Icon(
                        RemixIcons.calendar_line,
                        size: 14.r,
                        color: AppColors.gold,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        formatDate(date ?? '1999-07-1'),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: .w600,
                          color: AppColors.greyColor,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(Icons.circle, size: 8.r, color: AppColors.greyColor),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          '${formatTime(startTime ?? '04:15:34.096Z')} - ${formatTime(endTime ?? '04:15:34.096Z')}',
                          textAlign: .end,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: .w600,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: .all(4.r),
                      child: Text(
                        profession ?? 'N/A',
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 12.sp,
                          fontWeight: .w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
