import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';
import 'package:staffing/features/auth_features/views/login_views.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/forgot_password_features/view_models/forgot_password_view_model.dart';

class ForgotPasswordResetPasswordView extends StatelessWidget {
  final String resetToken;
  const ForgotPasswordResetPasswordView({super.key, required this.resetToken});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordTEC = TextEditingController();
    TextEditingController confirmPasswordTEC = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: 20.w),
              child: Consumer<ForgotPasswordViewModel>(
                builder: (context, provider, child) => Form(
                  key: formKey,
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
                        'Create New Password',
                        style: TextStyle(fontSize: 20.sp, fontWeight: .w700),
                      ),

                      SizedBox(height: 24.h),
                      customTextFieldWidget(
                        validator: (p0) => p0!.isEmpty ? 'Required' : null,
                        prefixIcon: Icons.lock_outline_rounded,
                        label: 'Password',
                        controller: passwordTEC,
                        textInputType: .text,
                        placeHolder: 'Enter new password',
                        suffixIcon: provider.passwordObsecure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        obscureText: provider.passwordObsecure,
                        onSuffixTap: () => provider.changePasswordObsecure(),
                      ),
                      SizedBox(height: 16.h),
                      customTextFieldWidget(
                        onChanged: (p0) => p0 != passwordTEC.text
                            ? "Password does not match"
                            : null,
                        validator: (p0) => p0!.isEmpty
                            ? 'Required'
                            : p0 != passwordTEC.text
                            ? 'Password does not match'
                            : null,
                        prefixIcon: Icons.lock_outline_rounded,
                        label: 'Confirm Password',
                        controller: confirmPasswordTEC,
                        textInputType: .text,
                        placeHolder: 'Confirm your password',
                        suffixIcon: provider.confirmPasswordObsecure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        obscureText: provider.confirmPasswordObsecure,
                        onSuffixTap: () =>
                            provider.changeConfirmPasswordObsecure(),
                      ),
                      SizedBox(height: 40.h),
                      Consumer<ForgotPasswordViewModel>(
                        builder: (context, provider, child) => Visibility(
                          visible: provider.isLoading == false,
                          replacement: Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: customElevatedButtonWidget(
                            text: 'Reset Password',
                            onTapped: () async {
                              if (formKey.currentState!.validate()) {
                                NetworkResponseModel responseModel =
                                    await provider.resetPassword(
                                      resetToken: resetToken,
                                      password: passwordTEC.text,
                                      passwordConfirm: confirmPasswordTEC.text,
                                    );
                                if (responseModel.isSuccess) {
                                  showStatusSnackbar(
                                    context,
                                    message: "Successfully reset password",
                                    type: .success,
                                  );
                                  context.pushRemoveUntil(LoginViews());
                                } else {
                                  showStatusSnackbar(
                                    context,
                                    message:
                                        responseModel.message ??
                                        "Failed to reset password",
                                    type: .error,
                                  );
                                }
                              }
                            },
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
      ),
    );
  }
}
