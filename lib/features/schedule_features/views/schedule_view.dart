import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/views/shift_details_view.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ScheduleViewModel>().changeTabIndex(0);
    });
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Schedule'),
      body: Padding(
        padding: .symmetric(horizontal: 20.w),
        child: Consumer<ScheduleViewModel>(
          builder: (context, provider, child) => Column(
            children: [
              TabBar(
                onTap: (value) {
                  provider.changeTabIndex(_tabController!.index);
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
                    'Upcoming Shifts (5) ',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: .w700,
                      color: AppColors.themeColorLight,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                    },
                    icon: Icon(
                      RemixIcons.calendar_line,
                      color: AppColors.themeColorLight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                  itemCount: 5 + 1,
                  itemBuilder: (context, index) => index == 5
                      ? SizedBox(height: 20.h)
                      : GestureDetector(
                          onTap: () => context.push(
                            ShiftDetailsView(isScheduleDetails: true, id: 0),
                          ),
                          child: ShiftCardWidget(
                            title: 'Sunrise Care Center',
                            location: 'Atlanta, GA',
                            date: 'May 20, 2026',
                            time: '7:00 AM - 3:00 PM',
                            status: provider.getStatus() == 'Upcoming'
                                ? ''
                                : provider.getStatus(),
                            ratePerHour: '\$58/hr',
                            image: AppAssets.hospitalImage,
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
