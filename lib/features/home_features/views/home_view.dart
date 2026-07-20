import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/extensions/capitalized.dart';
import 'package:staffing/app/services/auth_prefs_service.dart';
import 'package:staffing/app/utils/get_tier_icon.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
import 'package:staffing/features/home_features/models/home_dashboard_response_model.dart';
import 'package:staffing/features/home_features/models/home_upcoming_shift_response_model.dart';
import 'package:staffing/features/home_features/view_models/home_view_model.dart';
import 'package:staffing/features/home_features/widgets/at_glance_card_widget.dart';
import 'package:staffing/features/home_features/widgets/matric_tile_widget.dart';
import 'package:staffing/features/home_features/widgets/next_shift_card_widget.dart';
import 'package:staffing/features/home_main_nav_holder_features/view_models/main_home_nav_holder_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 13) {
      return "Good Noon"; // noon is also known as good noon
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initialize();
    });

    super.initState();
  }

  Future<void> _initialize() async {
    await context.read<HomeViewModel>().fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    AuthPrefsService().getRefreshToken().then(
      (value) => print('refreshsssssssssssssssssssssssss $value'),
    );
    AuthPrefsService().getToken().then(
      (value) => print('accessshsssssssssssssssssssssssss $value'),
    );

    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: RefreshIndicator(
        onRefresh: () async => await _initialize(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Consumer<HomeViewModel>(
              builder: (context, provider, child) {
                HomeDashboardResponseModel responseModel =
                    provider.homeDashboardResponseModel ??
                    HomeDashboardResponseModel();
                return Column(
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
                                DateFormat(
                                  'EEEE, MMMM d, y',
                                ).format(DateTime.now()),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: .w400,
                                  color: AppColors.greyColor,
                                ),
                              ),
                              Text(
                                '${_getGreeting()}, ${context.watch<LoginViewModel>().currentUser?.name ?? "".split(' ').last}',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: .w600,
                                ),
                              ),
                              Text(
                                'Ready for another great day of care?',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: .w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 72.h,
                          width: 72.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greyLight,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.network(
                              "${UrlList.baseUrl}${context.watch<LoginViewModel>().currentUser?.profilePicture ?? ''}",
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person_2_outlined,
                                  size: 30.r,
                                  color: AppColors.greyColor,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
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
                            width: 64.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.themeColorLight,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                getTierIcon(responseModel.lacScore?.tier ?? ""),
                                width: 64.w,
                                fit: .cover,
                              ),
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
                                '${responseModel.lacScore?.score ?? 0}',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: .w600,
                                  color: Colors.white,
                                ),
                              ),

                              // RatingBarIndicator(
                              //   rating: responseModel.lacScore?.score ?? 0.0,
                              //   itemBuilder: (context, index) =>
                              //       const Icon(Icons.star, color: Colors.amber),
                              //   itemCount: 5,
                              //   itemSize: 14.r,
                              //   direction: Axis.horizontal,
                              // ),
                              SizedBox(height: 4.h),
                              Text(
                                '${responseModel.lacScore?.tier}'.capitalize(),
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
                                  value:
                                      '${responseModel.lacScore?.reliability ?? 0}%',
                                ),
                                MatricTileWidget(
                                  icon: RemixIcons.time_line,
                                  title: 'Punctuality',
                                  value:
                                      '${responseModel.lacScore?.punctuality ?? 0}%',
                                ),
                                // MatricTileWidget(
                                //   icon: RemixIcons.user_3_line,
                                //   title: 'Performance',
                                //   value:
                                //       '${responseModel.lacScore?.performance ?? 0}/5',
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Wrap(
                      children: [
                        Text(
                          'Your Next Shift',
                          style: TextStyle(fontSize: 16.sp, fontWeight: .w500),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '/',
                          style: TextStyle(fontSize: 16.sp, fontWeight: .w500),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () {
                            context
                                .read<MainHomeNavHolderViewModel>()
                                .changeIndex(1);
                          },
                          child: Text(
                            'Available Shifts',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: .w500,
                              color: AppColors.themeColorLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    if (responseModel.upcomingShifts?.isEmpty ?? false)
                      Container(
                        width: .maxFinite,
                        padding: .all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius: .circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            'No Upcoming Shifts',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: .w500,
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: responseModel.upcomingShifts?.length ?? 0,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 4.h),
                        itemBuilder: (context, index) {
                          HomeUpcomingShiftResponseModel? model =
                              responseModel.upcomingShifts?[index];
                          return NextShiftCardWidget(
                            facilityName: model?.facilityName,
                            facilityCity: model?.facilityCity,
                            date: model?.shiftDate,
                            startTime: model?.startTime,
                            endTime: model?.endTime,
                            status: model?.assignmentStatus,
                            profession: model?.profession,
                            facilityImage: model?.facilityImage,
                          );
                        },
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
                        AtGlanceCardWidget(
                          title: '${responseModel.stats?.upcomingShifts ?? 0}',
                          subtitle: 'Upcoming Shift',
                        ),
                        AtGlanceCardWidget(
                          title:
                              '\$${responseModel.stats?.earningsThisWeek ?? 0}',
                          subtitle: 'Earnings This Week',
                        ),
                        AtGlanceCardWidget(
                          title:
                              '${responseModel.stats?.shiftsCompletedThisMonth ?? 0}',
                          subtitle: 'Shifts Completed This Month',
                        ),
                        AtGlanceCardWidget(
                          title:
                              '${responseModel.stats?.totalHoursThisMonth ?? 0}',
                          subtitle: 'Total Hours This Month',
                        ),
                      ]),
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
