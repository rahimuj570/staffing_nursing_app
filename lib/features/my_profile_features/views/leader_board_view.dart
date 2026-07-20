import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/capitalized.dart';
import 'package:staffing/features/my_profile_features/view_models/leader_board_view_model.dart';

class LeaderBoardView extends StatefulWidget {
  const LeaderBoardView({super.key});

  @override
  State<LeaderBoardView> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends State<LeaderBoardView> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _initializer();
    });
    super.initState();
  }

  void _initializer() async {
    context.read<LeaderBoardViewModel>().fetchLeaderBoardData();
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for leader board

    return Scaffold(
      appBar: AppBar(title: const Text('Leader Board')),
      body: Consumer<LeaderBoardViewModel>(
        builder: (context, provider, child) => provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.leaderBoardData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text('No data found'),
                    SizedBox(height: 20),
                    IconButton(
                      onPressed: () {
                        _initializer();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: provider.leaderBoardData.length,
                itemBuilder: (context, index) {
                  final entry = provider.leaderBoardData[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12.h),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '#${index + 1}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.themeColorDark,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              shape: .circle,
                              color: AppColors.greyLight,
                              border: Border.all(color: AppColors.greyColor),
                            ),
                            child: ClipRRect(
                              borderRadius: .circular(40.r),
                              child: Image.network(
                                entry.profilePicture ?? '',
                                fit: .cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Center(
                                      child: Text(
                                        entry.name?.substring(0, 1) ?? '',
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.name ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  entry.nurseType ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${entry.points ?? 0} pts',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.themeColor,
                                ),
                              ),
                              Text(
                                entry.tierName?.capitalize() ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.gold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
