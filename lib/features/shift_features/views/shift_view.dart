import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/services/network_service.dart';
import 'package:staffing/app/utils/format_date_util.dart';
import 'package:staffing/app/utils/format_time_util.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/common_features/views/shift_details_view.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/common_features/widgets/pagination_widget.dart';
import 'package:staffing/features/common_features/widgets/shift_card_widget.dart';
import 'package:staffing/features/shift_features/models/shift_response_model.dart';
import 'package:staffing/features/shift_features/view_models/shift_view_model.dart';
import 'package:staffing/features/shift_features/views/filter_shift_view.dart';

class ShiftView extends StatefulWidget {
  const ShiftView({super.key});

  @override
  State<ShiftView> createState() => _ShiftViewState();
}

class _ShiftViewState extends State<ShiftView> {
  TextEditingController searchTEC = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    searchTEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    NetworkService.instance.onRetry = _initialized;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initialized();
    });
    super.initState();
  }

  Future<void> _initialized() async {
    searchTEC.clear();
    await context.read<ShiftViewModel>().searchShifts(
      profession: context
          .read<LoginViewModel>()
          .nurseProfileMeResponseModel
          ?.nurseType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Shifts'),
      body: Padding(
        padding: .symmetric(horizontal: 20.0.w),
        child: Consumer<ShiftViewModel>(
          builder: (context, provider, child) => provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: customTextFieldWidget(
                            onFieldSubmitted: (p0) {
                              provider.searchShifts(facility: p0);
                            },
                            prefixIcon: RemixIcons.search_2_line,
                            label: '',
                            controller: searchTEC,
                            textInputType: .text,
                            placeHolder: 'Search...',
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () => provider.isFilteredResult
                              ? provider.fetchShifts()
                              : context.push(FilterShiftView()),
                          child: Container(
                            height: 46.h,
                            width: 46.w,
                            decoration: BoxDecoration(
                              color: AppColors.themeColorLight,
                              borderRadius: .circular(12.r),
                            ),
                            child: Icon(
                              provider.isFilteredResult
                                  ? RemixIcons.filter_off_fill
                                  : Remix.filter_line,
                              size: 20.r,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    provider.shiftResponseModel?.isEmpty ?? true
                        ? Center(
                            child: Column(
                              children: [
                                Text('No Shifts'),
                                IconButton(
                                  onPressed: () {
                                    _initialized();
                                  },
                                  icon: Icon(Icons.refresh),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async => _initialized(),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10.h),
                                itemCount:
                                    (provider.shiftResponseModel?.length ?? 0) +
                                    1,
                                itemBuilder: (context, index) {
                                  late ShiftResponseModel model;
                                  if (index !=
                                      provider.shiftResponseModel!.length) {
                                    model = provider.shiftResponseModel![index];
                                  }
                                  return index ==
                                          provider.shiftResponseModel!.length
                                      ? PaginationWidget(
                                          totalPages: provider.totalPages,
                                          fetchPreviousPage:
                                              provider.fetchPreviousPage,
                                          fetchNextPage: provider.fetchNextPage,
                                        )
                                      : GestureDetector(
                                          onTap: () => context.push(
                                            ShiftDetailsView(id: model.id),
                                          ),
                                          child: ShiftCardWidget(
                                            title: model.facility.name ?? 'N/A',
                                            location:
                                                model.facility.address ?? 'N/A',
                                            date: formatDate(
                                              model.shiftDate ?? '2026-07-1',
                                            ),
                                            time:
                                                '${formatTime(model.startTime ?? '00:00:00')} - ${formatTime(model.endTime ?? '00:00:00')}',
                                            status: model.profession ?? 'N/A',
                                            ratePerHour:
                                                model.payRate ?? '0.00',
                                            image: model.facility.image ?? '',
                                          ),
                                        );
                                },
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
