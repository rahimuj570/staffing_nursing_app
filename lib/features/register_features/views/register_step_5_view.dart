import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/register_features/views/register_successfull_view.dart';
import 'package:staffing/features/register_features/widgets/step_indicator_widget.dart';

class RegisterStep5View extends StatefulWidget {
  const RegisterStep5View({super.key});

  @override
  State<RegisterStep5View> createState() => _RegisterStep5ViewState();
}

class _RegisterStep5ViewState extends State<RegisterStep5View> {
  bool isTermsAccepted = false;
  bool isPrivacyPolicyAccepted = false;
  bool accuracyAgreementAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 16.h),
                Center(child: Image.asset(AppAssets.logoTransparemt)),
                SizedBox(height: 36.h),
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 20.sp, fontWeight: .w700),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: StepIndicatorWidget(totalSteps: 5, currentStep: 4),
                ),
                SizedBox(height: 16.h),
                // Text(
                //   'Are you interested in participating in our Housing Program?',
                //   style: TextStyle(fontSize: 14.sp, fontWeight: .w600),
                // ),
                // SizedBox(height: 10.h),
                Row(
                  children: [
                    Checkbox(
                      value: isTermsAccepted,
                      onChanged: (value) {
                        isTermsAccepted = value!;
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 16.sp,
                                fontWeight: .w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.themeColor,
                                fontSize: 14.sp,
                                fontWeight: .w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isPrivacyPolicyAccepted,
                      onChanged: (value) {
                        isPrivacyPolicyAccepted = value!;
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 16.sp,
                                fontWeight: .w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: AppColors.themeColor,
                                fontSize: 14.sp,
                                fontWeight: .w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: accuracyAgreementAccepted,
                      onChanged: (value) {
                        setState(() {
                          accuracyAgreementAccepted = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'I certify all information provided is accurate',
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 16.sp,
                                fontWeight: .w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                customElevatedButtonWidget(
                  text: 'Submit Application',
                  onTapped:
                      isTermsAccepted == true &&
                          isPrivacyPolicyAccepted == true &&
                          accuracyAgreementAccepted == true
                      ? () {
                          showSuccessDialog(context);
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Allows closing by tapping outside
      barrierColor: Colors.black.withValues(
        alpha: 0.4,
      ), // Darkens background slightly
      builder: (BuildContext context) {
        return BackdropFilter(
          // 1. Apply Background Blur Effect
          filter: ImageFilter.blur(sigmaX: 5.0.w, sigmaY: 5.0.h),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                28.0.r,
              ), // Rounded corners matching design
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.all(24.0), // Outer margins
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0.w,
                vertical: 32.0.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content tightly
                children: [
                  // 2. Success Checkmark Circle
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF1A458B), // Navy blue circle
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.r,
                          offset: Offset(0.w, 4.h),
                        ),
                      ],
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 44.r),
                  ),
                  SizedBox(height: 24.h),

                  // 3. Main Title
                  Text(
                    'Application Submitted\nSuccessfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F2547), // Dark navy text
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // 4. Description Subtitle
                  Text(
                    'Thank you for applying. Our team is currently reviewing your documents and conducting verification checks.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xFF64748B), // Slate gray text
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // 5. Action "Done" Button
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.pushRemoveUntil(
                          RegisterSuccessfullView(),
                        ); // Closes the modal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F2D5C), // Deep navy
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
