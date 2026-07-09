import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/services/auth_prefs_service.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/register_features/view_models/register_user_view_model.dart';
import 'package:staffing/features/register_features/views/register_step_2_view.dart';

class RegisterUserOtpVeficationView extends StatefulWidget {
  final String email;
  const RegisterUserOtpVeficationView({super.key, required this.email});

  @override
  State<RegisterUserOtpVeficationView> createState() =>
      _RegisterUserOtpVeficationViewState();
}

class _RegisterUserOtpVeficationViewState
    extends State<RegisterUserOtpVeficationView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool enableVerifyBtn = false;

  @override
  void dispose() {
    // TODO: implement dispose
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Consumer<RegisterUserViewModel>(
              builder: (context, provider, child) => Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 16.h),
                    Center(
                      child: Image.asset(
                        AppAssets.logoTransparemt,
                        width: 182.w,
                      ),
                    ),
                    SizedBox(height: 80.h),
                    Text(
                      'OTP Verification',
                      style: TextStyle(fontSize: 20.sp, fontWeight: .w700),
                    ),

                    SizedBox(height: 24.h),
                    Center(
                      child: Pinput(
                        length: 6,
                        controller: otpController,
                        defaultPinTheme: PinTheme(
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
                          return s!.length == 6
                              ? null
                              : 'Please enter 6 digits';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onChanged: (value) => value.length != 6
                            ? setState(() {
                                enableVerifyBtn = false;
                              })
                            : setState(() {
                                enableVerifyBtn = true;
                              }),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Consumer<RegisterUserViewModel>(
                      builder: (context, provider, child) => Visibility(
                        visible: provider.isLoading == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: customElevatedButtonWidget(
                          text: 'Verify Code',
                          onTapped: enableVerifyBtn
                              ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    NetworkResponseModel responseModel =
                                        await provider.verifyOtp(
                                          email: widget.email,
                                          otp: otpController.text,
                                        );

                                    if (responseModel.isSuccess) {
                                      showStatusSnackbar(
                                        context,
                                        message: "OTP verified successfully",
                                        type: MessageType.success,
                                      );

                                      AuthPrefsService().saveToken(
                                        responseModel
                                            .responseData['data']["access"],
                                      );
                                      AuthPrefsService().saveRefreshToken(
                                        responseModel
                                            .responseData['data']["refresh"],
                                      );
                                      context.pushReplacement(
                                        const RegisterStep2View(),
                                      );
                                    } else {
                                      showStatusSnackbar(
                                        context,
                                        message:
                                            responseModel.message ??
                                            'OTP verification failed',
                                        type: MessageType.error,
                                      );
                                    }
                                  }
                                }
                              : null,
                        ),
                      ),
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
                            provider.resendOtpTimer == 0
                                ? TextSpan(
                                    text: 'Resend',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: .w600,
                                      color: AppColors.themeColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => provider.resendOtp(
                                        email: widget.email,
                                      ),
                                  )
                                : TextSpan(
                                    text:
                                        'Resend in ${provider.resendOtpTimer}s',
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
        ),
      ),
    );
  }
}
