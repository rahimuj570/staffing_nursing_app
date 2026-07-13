import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/utils/format_date_util.dart';
import 'package:staffing/app/utils/format_time_util.dart';
import 'package:staffing/app/utils/get_duration_from_date_range.dart';
import 'package:staffing/app/utils/get_week_day_name.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/read_more_text_widget.dart';
import 'package:staffing/features/message_features/views/chat_view.dart';
import 'package:staffing/features/schedule_features/view_models/schedule_view_model.dart';
import 'package:staffing/features/shift_features/models/shift_detail_response.dart';
import 'package:staffing/features/shift_features/services/favourite_service.dart';
import 'package:staffing/features/shift_features/view_models/shift_view_model.dart';
import 'package:staffing/features/shift_features/views/shift_confirmation_view.dart';

class ShiftDetailsView extends StatefulWidget {
  final bool isScheduleDetails;
  final int id;
  const ShiftDetailsView({
    super.key,
    this.isScheduleDetails = false,
    required this.id,
  });

  @override
  State<ShiftDetailsView> createState() => _ShiftDetailsViewState();
}

class _ShiftDetailsViewState extends State<ShiftDetailsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initialized();
    });
    // TODO: implement initState
    super.initState();
  }

  Future<void> _initialized() async {
    await context.read<ShiftViewModel>().fetchShiftDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shift Details')),
      body: Consumer<ShiftViewModel>(
        builder: (context, provider, child) {
          if (provider.isLoading || provider.shiftDetailResponse == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            ShiftDetailResponse shiftDetailResponse =
                provider.shiftDetailResponse!;
            return Padding(
              padding: .symmetric(horizontal: 20.0.w),
              child: RefreshIndicator(
                onRefresh: () async => await _initialized(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Container(
                              height: 96.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: ClipRRect(
                                borderRadius: .circular(8.r),
                                child: Image.network(
                                  shiftDetailResponse.facility.image ?? '',
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.error),
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          loadingProgress == null
                                          ? child
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    shiftDetailResponse.facility.name ?? '',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: .w700,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.gold,
                                        size: 20.r,
                                      ),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Text(
                                          shiftDetailResponse
                                                  .facility
                                                  .address ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: .w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Wrap(
                                    children: [
                                      Container(
                                        padding: .symmetric(
                                          horizontal: 8.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.greyLight,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Text(
                                          shiftDetailResponse.profession ??
                                              'N/A',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: .w400,
                                            color: AppColors.themeColorLight,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Container(
                                        padding: .symmetric(
                                          horizontal: 8.w,
                                          vertical: 4.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.shade200,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Text(
                                          shiftDetailResponse.shiftType != null
                                              ? shiftDetailResponse
                                                        .shiftType![0]
                                                        .toUpperCase() +
                                                    shiftDetailResponse
                                                        .shiftType!
                                                        .substring(1)
                                              : 'N/A',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: .w400,
                                            color: AppColors.gold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        GridView.custom(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.4,
                                crossAxisCount: 2,
                                mainAxisSpacing: 8.h,
                                crossAxisSpacing: 8.w,
                              ),
                          childrenDelegate: SliverChildListDelegate([
                            ShiftShortInfoCardWidget(
                              icon: RemixIcons.calendar_line,
                              title: formatDate(
                                shiftDetailResponse.shiftDate ?? '1999:9:9',
                              ),
                              subtitle: getWeekdayName(
                                DateTime.parse(
                                  shiftDetailResponse.shiftDate ?? '1999:9:9',
                                ).weekday,
                              ),
                            ),
                            ShiftShortInfoCardWidget(
                              icon: Icons.watch_later_outlined,
                              title:
                                  '${formatTime(shiftDetailResponse.startTime ?? '00:00:00')} - ${formatTime(shiftDetailResponse.endTime ?? '00:00:00')}',
                              subtitle:
                                  '(${getDurationFromDateRange(shiftDetailResponse.startTime ?? '02:53:53', shiftDetailResponse.endTime ?? '02:53:53')})',
                            ),
                            ShiftShortInfoCardWidget(
                              icon: RemixIcons.bank_card_2_line,
                              title: shiftDetailResponse.payFrequency != null
                                  ? shiftDetailResponse.payFrequency![0]
                                            .toUpperCase() +
                                        shiftDetailResponse.payFrequency!
                                            .substring(1)
                                  : 'N/A',
                              subtitle: '',
                            ),
                            ShiftShortInfoCardWidget(
                              icon: Icons.attach_money_rounded,
                              title:
                                  '\$${shiftDetailResponse.payRate ?? 0} /hr',
                              subtitle:
                                  'Est. \$${shiftDetailResponse.estimatedPay ?? 0}',
                            ),
                          ]),
                        ),
                        SizedBox(height: 16.h),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: .all(12.r),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  'Shift Information',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: .w600,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                ListView.custom(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  childrenDelegate: SliverChildListDelegate.fixed([
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.community_line,
                                      title: 'Unit / Department',
                                      subtitle:
                                          shiftDetailResponse.department ??
                                          'N/A',
                                    ),
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.group_line,
                                      title: 'Number of Openings',
                                      subtitle:
                                          '${shiftDetailResponse.openingsLeft}',
                                    ),
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.sun_line,
                                      title: 'Shift Type',
                                      subtitle:
                                          shiftDetailResponse.shiftType != null
                                          ? shiftDetailResponse.shiftType![0]
                                                    .toUpperCase() +
                                                shiftDetailResponse.shiftType!
                                                    .substring(1)
                                          : 'N/A',
                                    ),
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.user_3_line,
                                      title: 'Assignment',
                                      subtitle:
                                          shiftDetailResponse.assignmentType ??
                                          'N/A',
                                    ),
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.group_line,
                                      title: 'Patient Ratio',
                                      subtitle:
                                          shiftDetailResponse.patientRatio ??
                                          'N/A',
                                    ),
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.spam_2_line,
                                      title: 'Mandatory Float',
                                      subtitle:
                                          shiftDetailResponse.mandatoryFloat !=
                                              null
                                          ? shiftDetailResponse.mandatoryFloat!
                                                ? 'Yes'
                                                : 'No'
                                          : 'N/A',
                                    ),
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.verified_badge_line,
                                      title: 'Experience Required',
                                      subtitle:
                                          '${shiftDetailResponse.experienceRequiredYears}+ years',
                                    ),
                                    ShiftInformationTileWidget(
                                      icon: RemixIcons.t_shirt_line,
                                      title: 'Dress Code',
                                      subtitle:
                                          shiftDetailResponse.dressCode ??
                                          'N/A',
                                      hideDivider: true,
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: .all(12.0.r),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  'Notes from Facility',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: .w600,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: .maxFinite,
                                  child: ReadMoreTextWidget(
                                    text: shiftDetailResponse.notes ?? 'N/A',
                                    trimLines: 2,
                                    textStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(
                                        0xFF6B7280,
                                      ), // Neutral slate body paragraph font color
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                    ),
                                    actionTextStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(
                                        0xFF0F2D5C,
                                      ), // Navy bold actionable hyperlink text color
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: .all(12.r),
                            child: Row(
                              children: [
                                Image.asset(AppAssets.demoMap),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: AppColors.gold,
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(
                                              '${shiftDetailResponse.facility.address}, ${shiftDetailResponse.facility.city}, ${shiftDetailResponse.facility.state}',
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.car_repair_outlined,
                                            color: AppColors.gold,
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(
                                              '${shiftDetailResponse.distanceKm}',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        if (widget.isScheduleDetails == false)
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  provider.toggleFavourite(
                                    shiftDetailResponse.id!,
                                  );
                                },
                                child: Container(
                                  width: 48.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: .circular(12.r),
                                    border: .all(color: AppColors.themeColor),
                                  ),
                                  child: Icon(
                                    provider.isFavourite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: AppColors.themeColor,
                                    size: 26.r,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: customElevatedButtonWidget(
                                  text: 'I want this Shift',
                                  onTapped: () {
                                    context.push(
                                      ShiftConfirmationView(
                                        response: shiftDetailResponse,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                        if (widget.isScheduleDetails == true)
                          Consumer<ScheduleViewModel>(
                            builder: (context, provider, child) => Column(
                              children: [
                                customElevatedButtonWidget(
                                  icon: Icons.watch_later_outlined,
                                  text: provider.isClockIn == true
                                      ? 'Clock Out'
                                      : 'Clock In',
                                  onTapped: () {
                                    provider.changeClockIn();
                                  },
                                ),
                                SizedBox(height: 12.h),
                                customElevatedButtonWidget(
                                  icon: Icons.close,
                                  backgroundColor: Colors.white,
                                  forgroundColor: AppColors.themeColor,
                                  borderColor: AppColors.themeColor,
                                  text: 'Cancel The Shift',
                                  onTapped: () {
                                    context.pop();
                                  },
                                ),
                                SizedBox(height: 12.h),
                                customElevatedButtonWidget(
                                  icon: Icons.email_outlined,
                                  backgroundColor: Colors.white,
                                  forgroundColor: AppColors.themeColor,
                                  borderColor: AppColors.themeColor,
                                  text: 'Message',
                                  onTapped: () {
                                    context.push(ChatView());
                                  },
                                ),
                                SizedBox(height: 8.h),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ShiftInformationTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hideDivider;
  const ShiftInformationTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hideDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.greyColor),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(fontSize: 12.sp, fontWeight: .w600),
            ),
            Spacer(),
            Expanded(
              child: Text(
                subtitle,
                textAlign: .end,
                style: TextStyle(fontSize: 12.sp, fontWeight: .w500),
              ),
            ),
          ],
        ),
        if (hideDivider == false) Divider(),
        if (hideDivider == false) SizedBox(height: 8.h),
      ],
    );
  }
}

class ShiftShortInfoCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const ShiftShortInfoCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(icon, size: 24.r),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: .w600),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12.sp, fontWeight: .w400),
            ),
          ],
        ),
      ),
    );
  }
}
