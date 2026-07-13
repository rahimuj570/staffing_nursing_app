import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/services/auth_prefs_service.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/auth_features/views/login_views.dart';
import 'package:staffing/features/common_features/widgets/custom_app_bar_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/my_profile_features/view_models/my_profile_view_model.dart';
import 'package:staffing/features/my_profile_features/views/about_us_view.dart';
import 'package:staffing/features/my_profile_features/views/document_and_certifications_view.dart';
import 'package:staffing/features/my_profile_features/views/privacy_policy_view.dart';
import 'package:staffing/features/my_profile_features/views/profile_information_view.dart';
import 'package:staffing/features/my_profile_features/views/terms_and_service_view.dart';
import 'package:staffing/features/my_profile_features/widgets/my_profile_info_card_widget.dart';
import 'package:staffing/features/my_profile_features/widgets/my_profile_menu_widget.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  Future<void> _initialize() async {
    await context.read<MyProfileViewModel>().fetchMyProfileContent();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initialize();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'My Profile'),
      body: Padding(
        padding: .all(20.0.r),
        child: RefreshIndicator(
          onRefresh: () => _initialize(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: .all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: .circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: .start,
                        children: [
                          Container(
                            height: 72.h,
                            width: 72.w,
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
                                Row(
                                  children: [
                                    Text(
                                      '${context.read<LoginViewModel>().currentUser?.name}',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: .w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Icon(
                                      Icons.verified_rounded,
                                      color: Colors.blue,
                                      size: 15.r,
                                    ),
                                  ],
                                ),
                                Text(
                                  '${context.read<LoginViewModel>().nurseProfileMeResponseModel?.nurseType}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.verified_user_outlined,
                                      color: AppColors.gold,
                                      size: 18.r,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      'Verified Nurse',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: .w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'License: ${context.read<LoginViewModel>().nurseProfileMeResponseModel?.licenseNumber}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: .w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   'License: ${context.read<LoginViewModel>().nurseProfileMeResponseModel?.licenseNumber} | Expires: Dec 31, 2026',
                                //   style: TextStyle(
                                //     fontSize: 12.sp,
                                //     fontWeight: .w600,
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Divider(color: AppColors.themeColorLight),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 20, // space between items
                        runSpacing: 8, // space between lines when wrapped
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: .min,
                            spacing: 4.w,
                            children: [
                              Icon(
                                Icons.call_outlined,
                                color: Colors.white,
                                size: 18.r,
                              ),
                              Text(
                                '${context.read<LoginViewModel>().currentUser?.phone}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: .w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                            ],
                          ),
                          Row(
                            mainAxisSize: .min,
                            spacing: 4.w,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                                size: 18.r,
                              ),
                              Text(
                                '${context.read<LoginViewModel>().currentUser?.email}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: .w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 4.w),
                          Row(
                            mainAxisSize: .min,
                            spacing: 4.w,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 18.r,
                              ),
                              Expanded(
                                child: Text(
                                  '${context.read<LoginViewModel>().nurseProfileMeResponseModel?.address}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: .w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                GridView.custom(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5,
                    crossAxisCount: 2,
                  ),
                  childrenDelegate: SliverChildListDelegate([
                    MyProfileInfoCardWidget(
                      icon: RemixIcons.calendar_line,
                      title: '25',
                      subtitle: 'Shift Completed This Month',
                    ),
                    MyProfileInfoCardWidget(
                      icon: Icons.watch_later_outlined,
                      title: '120',
                      subtitle: 'Total Hours This Month',
                    ),
                    MyProfileInfoCardWidget(
                      icon: Icons.attach_money_outlined,
                      title: '\$255.53',
                      subtitle: 'Earnings This Month',
                    ),
                    MyProfileInfoCardWidget(
                      icon: Icons.star_border_outlined,
                      title: '4.9',
                      subtitle: 'Overall rating',
                    ),
                  ]),
                ),
                SizedBox(height: 16.h),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: .all(16.r),
                    child: Column(
                      children: [
                        MytProfileMenuWidget(
                          icon: RemixIcons.user_settings_line,
                          title: 'Profile Information',
                          onTap: () {
                            context.push(ProfileInformationView());
                          },
                        ),
                        Padding(
                          padding: .only(top: 4.0.h, bottom: 8.h),
                          child: Divider(color: AppColors.greyLight),
                        ),
                        MytProfileMenuWidget(
                          icon: RemixIcons.file_text_line,
                          title: 'Documents & Certifications',
                          onTap: () {
                            context.push(DocumentAndCertificationsView());
                          },
                        ),
                        Padding(
                          padding: .only(top: 4.0.h, bottom: 8.h),
                          child: Divider(color: AppColors.greyLight),
                        ),
                        MytProfileMenuWidget(
                          icon: RemixIcons.file_shield_2_line,
                          title: 'Privacy Policy',
                          onTap: () {
                            context.push(const PrivacyPolicyView());
                          },
                        ),
                        Padding(
                          padding: .only(top: 4.0.h, bottom: 8.h),
                          child: Divider(color: AppColors.greyLight),
                        ),
                        MytProfileMenuWidget(
                          icon: RemixIcons.file_info_line,
                          title: 'Terms of Services',
                          onTap: () {
                            context.push(TermsAndServiceView());
                          },
                        ),
                        Padding(
                          padding: .only(top: 4.0.h, bottom: 8.h),
                          child: Divider(color: AppColors.greyLight),
                        ),
                        MytProfileMenuWidget(
                          icon: RemixIcons.file_unknow_line,
                          title: 'About Us',
                          onTap: () {
                            context.push(const AboutUsView());
                          },
                        ),
                        Padding(
                          padding: .only(top: 4.0.h, bottom: 8.h),
                          child: Divider(color: AppColors.greyLight),
                        ),
                        MytProfileMenuWidget(
                          icon: RemixIcons.logout_box_r_line,
                          title: 'Logout',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: .only(
                                    topLeft: Radius.circular(24.r),
                                    topRight: Radius.circular(24.r),
                                  ),
                                  color: Colors.white,
                                ),
                                width: double.maxFinite,
                                padding: .symmetric(
                                  horizontal: 20.w,
                                  vertical: 30.h,
                                ),
                                child: SafeArea(
                                  top: false,
                                  child: Column(
                                    mainAxisSize: .min,
                                    children: [
                                      Container(
                                        height: 4.h,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.greyLight,
                                          borderRadius: .circular(2.r),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: .w600,
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Divider(color: AppColors.greyLight),
                                      SizedBox(height: 16.h),
                                      Text(
                                        'Are you sure you want to log out?',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: .w400,
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: customElevatedButtonWidget(
                                              text: 'Yes, Logout',
                                              onTapped: () async {
                                                await AuthPrefsService()
                                                    .removeToken();
                                                context.pushRemoveUntil(
                                                  LoginViews(),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: customElevatedButtonWidget(
                                              backgroundColor: Colors.white,
                                              forgroundColor:
                                                  AppColors.themeColor,
                                              borderColor: AppColors.themeColor,
                                              text: 'Cancel',
                                              onTapped: () {
                                                context.pop();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
