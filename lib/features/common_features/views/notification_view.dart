import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/utils/time_ago_Label_util.dart';
import 'package:staffing/features/common_features/models/notification_response_model.dart';
import 'package:staffing/features/common_features/models/view_models/notification_view_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (context.read<NotificationViewModel>().next == null) {
          return;
        }
        context.read<NotificationViewModel>().fetchNextPage();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _initializer();
    });
    super.initState();
  }

  void _initializer() async {
    await context.read<NotificationViewModel>().fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Padding(
        padding: .symmetric(horizontal: 20.w),
        child: Consumer<NotificationViewModel>(
          builder: (context, provider, child) => provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Visibility(
                  visible: provider.isLoading == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.separated(
                    controller: scrollController,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemCount: provider.notifications.length + 1,
                    itemBuilder: (context, index) {
                      if (index == provider.notifications.length) {
                        if (provider.next == null) {
                          return Center(child: Text('No more notifications'));
                        }
                        return provider.isFetchingNextPage
                            ? Center(child: CircularProgressIndicator())
                            : null;
                      } else {
                        NotificationResponseModel model =
                            provider.notifications[index];
                        return InkWell(
                          onTap: () {
                            provider.readNotification(model.id ?? 0);
                            provider.locallyReadNotification(model.id ?? 0);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Align(
                                    alignment: .topEnd,
                                    child: IconButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  ),
                                  content: Column(
                                    crossAxisAlignment: .start,
                                    mainAxisSize: .min,
                                    children: [
                                      Text(
                                        '${model.title}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: .w600,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        model.body ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: .w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: .circle,
                                ),
                                child: Icon(
                                  Icons.notifications_none_rounded,
                                  size: 26.r,
                                  color: AppColors.themeColorLight,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '${model.body}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: model.isRead ?? false
                                            ? .w400
                                            : .w600,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 16.r,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          timeAgoLabel(
                                            DateTime.parse(
                                              model.createdAt ??
                                                  '2023-01-01T00:00:00.000Z',
                                            ),
                                          ),
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
