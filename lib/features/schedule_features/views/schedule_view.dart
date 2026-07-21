import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/services/network_service.dart';
import 'package:staffing/app/utils/format_date_util.dart';
import 'package:staffing/app/utils/format_time_util.dart';
import 'package:staffing/features/common_features/views/shift_details_view.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
import 'package:staffing/features/common_features/widgets/pagination_widget.dart';
import 'package:staffing/features/common_features/widgets/shift_card_widget.dart';
import 'package:staffing/features/schedule_features/view_models/schedule_view_model.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    NetworkService.instance.onRetry = _initialize;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<ScheduleViewModel>().changeTabIndex(0);
      await _initialize();
    });
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  Future<void> _initialize({DateTime? date}) async {
    await context.read<ScheduleViewModel>().fetchSchedule(date: date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Schedule'),
      body: Padding(
        padding: .symmetric(horizontal: 20.w),
        child: Consumer<ScheduleViewModel>(
          builder: (context, provider, child) => provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    TabBar(
                      onTap: (value) async {
                        provider.changeTabIndex(_tabController!.index);
                        await provider.fetchSchedule();
                      },
                      controller: _tabController,
                      indicatorSize: .tab,
                      dividerHeight: 0,
                      tabs: [
                        Tab(child: Text('Upcoming')),
                        Tab(child: Text('Completed')),
                        Tab(child: Text('Cancelled')),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '${provider.getStatus()} Shifts (${provider.count}) ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: .w700,
                            color: AppColors.themeColorLight,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );

                            await _initialize(date: date);
                          },
                          icon: Icon(
                            provider.isDateFiltered
                                ? RemixIcons.calendar_check_line
                                : RemixIcons.calendar_line,
                            color: AppColors.themeColorLight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => _initialize(),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                          itemCount: provider.schedules.length + 1,
                          itemBuilder: (context, index) => provider.count == 0
                              ? Center(child: Text('No Schedule Found'))
                              : index == provider.schedules.length
                              ? PaginationWidget(
                                  totalPages: provider.totalPages,
                                  fetchPreviousPage: provider.fetchPreviousPage,
                                  fetchNextPage: provider.fetchNextPage,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    provider.isClockIn =
                                        provider
                                            .schedules[index]
                                            .activeClockLog !=
                                        null;
                                    context.push(
                                      ShiftDetailsView(
                                        isScheduleDetails: true,
                                        id: provider
                                            .schedules[index]
                                            .shift!
                                            .id!,
                                        assignmentId:
                                            provider.schedules[index].id,
                                        status:
                                            provider.schedules[index].status,
                                      ),
                                      then: (value) async =>
                                          await _initialize(),
                                    );
                                  },
                                  child: ShiftCardWidget(
                                    title:
                                        provider
                                            .schedules[index]
                                            .shift!
                                            .facility
                                            .name ??
                                        '',
                                    location:
                                        provider
                                            .schedules[index]
                                            .shift!
                                            .facility
                                            .address ??
                                        '',
                                    date: formatDate(
                                      provider
                                              .schedules[index]
                                              .shift!
                                              .shiftDate ??
                                          '1999-9-9',
                                    ),
                                    time:
                                        '${formatTime(provider.schedules[index].shift!.startTime ?? '0:0:0')} - ${formatTime(provider.schedules[index].shift!.endTime ?? '0:0:0')}',
                                    status: provider.getStatus() == 'Upcoming'
                                        ? ''
                                        : provider.getStatus(),
                                    ratePerHour:
                                        '${provider.schedules[index].shift!.payRate}',
                                    image:
                                        provider
                                            .schedules[index]
                                            .shift!
                                            .facility
                                            .image ??
                                        '',
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
