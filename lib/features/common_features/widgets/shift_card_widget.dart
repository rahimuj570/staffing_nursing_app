import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';

class ShiftCardWidget extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String time;
  final String status;
  final String ratePerHour;
  final String image;
  const ShiftCardWidget({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
    required this.ratePerHour,
    required this.image,
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
                child: Image.network(
                  width: 120.w,
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                      ? child
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 14.sp, fontWeight: .w700),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      if (status.isNotEmpty)
                        Container(
                          padding: .symmetric(horizontal: 5.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: status == 'Cancelled'
                                ? Colors.red.shade100
                                : AppColors.greyLight,
                            borderRadius: BorderRadius.circular(21.r),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: .w400,
                              color: status == 'Cancelled'
                                  ? Colors.red
                                  : AppColors.themeColorLight,
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
                      Expanded(
                        child: Text(
                          location,
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

                  Row(
                    children: [
                      Icon(
                        RemixIcons.calendar_line,
                        size: 14.r,
                        color: AppColors.gold,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        date,
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
                          time,
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
                  SizedBox(height: 6.h),
                  Text(
                    '\$$ratePerHour/hr',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: .w700,
                      color: AppColors.themeColor,
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
