import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';

import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/forgot_password_features/view_models/forgot_password_view_model.dart';
import 'package:staffing/features/forgot_password_features/views/forgot_password_otp_vefication_view.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailTEC = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 16.h),
                Center(
                  child: Image.asset(AppAssets.logoTransparemt, width: 182.w),
                ),
                SizedBox(height: 80.h),
                Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 20.sp, fontWeight: .w700),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please enter your email to reset your password',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: .w400,
                    color: AppColors.greyColor,
                  ),
                ),
                SizedBox(height: 24.h),
                customTextFieldWidget(
                  label: 'Email',
                  controller: emailTEC,
                  textInputType: .emailAddress,
                  placeHolder: 'Enter your email',
                ),
                SizedBox(height: 40.h),
                Consumer<ForgotPasswordViewModel>(
                  builder: (context, provider, child) => provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : customElevatedButtonWidget(
                          text: 'Send OTP',
                          onTapped: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (emailTEC.text.isEmpty ||
                                RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                    ).hasMatch(emailTEC.text) ==
                                    false) {
                              showStatusSnackbar(
                                context,
                                message: "Need to enter a valid email",
                                type: .error,
                              );
                            } else {
                              NetworkResponseModel response = await provider
                                  .requestForOTP(email: emailTEC.text.trim());

                              if (response.isSuccess) {
                                showStatusSnackbar(
                                  context,
                                  message:
                                      response.message ??
                                      'OTP has been sent to your email',
                                  type: .success,
                                );
                                context.push(
                                  ForgotPasswordOtpVeficationView(
                                    email: emailTEC.text.trim(),
                                  ),
                                );
                              } else {
                                showStatusSnackbar(
                                  context,
                                  message:
                                      response.message ??
                                      'Faild to request OTP. Try again!',
                                  type: .error,
                                );
                              }
                            }
                          },
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
