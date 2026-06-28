import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
import 'package:staffing/features/message_features/views/chat_view.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Messages'),
      body: Padding(
        padding: .symmetric(horizontal: 20.0.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => context.push(ChatView()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: .circular(12.r),
                    ),
                    padding: .symmetric(horizontal: 14.w, vertical: 16.h),
                    child: Row(
                      children: [
                        Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: BoxDecoration(
                            shape: .circle,
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: .circular(50.r),
                            child: Image.asset(
                              AppAssets.nurseDp,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                'Savannah Nguyen',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: .w600,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Sequi quae aliquid numquam.wsd dsdsads',
                                style: TextStyle(
                                  overflow: .ellipsis,
                                  fontSize: 14.sp,
                                  fontWeight: .w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Column(
                          crossAxisAlignment: .end,
                          children: [
                            Text(
                              ' 08:09 PM',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: .w500,
                                color: AppColors.greyColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Container(
                              padding: .all(6.r),
                              decoration: BoxDecoration(
                                shape: .circle,
                                color: AppColors.themeColor,
                              ),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: .w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
