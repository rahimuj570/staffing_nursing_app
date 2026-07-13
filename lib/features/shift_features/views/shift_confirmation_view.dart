import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/utils/format_date_util.dart';
import 'package:staffing/app/utils/format_time_util.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';
import 'package:staffing/features/common_features/views/shift_details_view.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/shift_features/models/shift_detail_response.dart';
import 'package:staffing/features/shift_features/view_models/shift_view_model.dart';
import 'package:staffing/features/shift_features/views/shift_accepted_successfull_view.dart';

class ShiftConfirmationView extends StatelessWidget {
  final ShiftDetailResponse response;
  const ShiftConfirmationView({super.key, required this.response});

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
                              subtitle: response.facility.name ?? '',
                            ),
                            ShiftInformationTileWidget(
                              icon: RemixIcons.calendar_2_line,
                              title: 'Date',
                              subtitle: formatDate(
                                response.shiftDate ?? '1999-9-9',
                              ),
                            ),
                            ShiftInformationTileWidget(
                              icon: RemixIcons.timer_2_line,
                              title: 'Time',
                              subtitle:
                                  '${formatTime(response.startTime ?? '0:0:0')} – ${formatTime(response.endTime ?? '0:0:0')}',
                            ),
                            ShiftInformationTileWidget(
                              icon: Icons.attach_money_outlined,
                              title: 'Pay Rate',
                              subtitle: '\$${response.payRate}/hr',
                            ),
                            ShiftInformationTileWidget(
                              hideDivider: true,
                              icon: RemixIcons.map_pin_2_line,
                              title: 'Distance',
                              subtitle: '${response.distanceKm} KM Away',
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: .symmetric(horizontal: 20.0.w),
          child: Consumer<ShiftViewModel>(
            builder: (context, viewModel, child) => viewModel.isBooking
                ? SizedBox(
                    height: 100.h,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    mainAxisSize: .min,
                    children: [
                      customElevatedButtonWidget(
                        text: 'Confirm Shift',
                        onTapped: () async {
                          NetworkResponseModel responseModel = await viewModel
                              .bookShift(response.id ?? 0);

                          if (responseModel.isSuccess) {
                            context.pushReplacement(
                              ShiftAcceptedSuccessfullView(response: response),
                            );
                          } else {
                            showStatusSnackbar(
                              context,
                              message:
                                  responseModel.message ?? 'Failed to book!',
                              type: .error,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 16.h),
                      customElevatedButtonWidget(
                        borderColor: AppColors.themeColor,
                        backgroundColor: Colors.white,
                        forgroundColor: AppColors.themeColor,
                        text: 'Cancel',
                        onTapped: () {
                          context.pop();
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
