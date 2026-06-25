import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/forgot_password_features/views/forgot_password_reset_password_view.dart';

class ForgotPasswordOtpVeficationView extends StatelessWidget {
  const ForgotPasswordOtpVeficationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 16.h),
                Center(child: Image.asset(AppAssets.logoTransparemt)),
                SizedBox(height: 80.h),
                Text(
                  'OTP Verification',
                  style: TextStyle(fontSize: 20.sp, fontWeight: .w700),
                ),

                SizedBox(height: 24.h),
                Center(
                  child: Pinput(
                    defaultPinTheme: PinTheme(
                      margin: .symmetric(horizontal: 8.w),
                      width: 56.w,
                      height: 56.h,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.themeColor),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    validator: (s) {
                      return s == '2222' ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                  ),
                ),
                SizedBox(height: 40.h),
                customElevatedButtonWidget(
                  text: 'Verify Code',
                  onTapped: () {
                    context.push(ForgotPasswordResetPasswordView());
                  },
                ),
                SizedBox(height: 16.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Haven’t receive the code? ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: .w400,
                            color: AppColors.greyColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Resend',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: .w600,
                            color: AppColors.themeColor,
                          ),
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
