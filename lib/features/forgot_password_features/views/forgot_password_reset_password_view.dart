import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/auth_features/views/login_views.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/forgot_password_features/view_models/forgot_password_view_model.dart';

class ForgotPasswordResetPasswordView extends StatelessWidget {
  const ForgotPasswordResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailTEC = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Consumer<ForgotPasswordViewModel>(
              builder: (context, provider, child) => Form(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 16.h),
                    Center(child: Image.asset(AppAssets.logoTransparemt)),
                    SizedBox(height: 80.h),
                    Text(
                      'Create New Password',
                      style: TextStyle(fontSize: 20.sp, fontWeight: .w700),
                    ),

                    SizedBox(height: 24.h),
                    customTextFieldWidget(
                      prefixIcon: Icons.lock_outline_rounded,
                      label: 'Password',
                      controller: emailTEC,
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
                      prefixIcon: Icons.lock_outline_rounded,
                      label: 'Confirm Password',
                      controller: emailTEC,
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
                    customElevatedButtonWidget(
                      text: 'Reset Password',
                      onTapped: () {
                        context.push(LoginViews());
                      },
                    ),

                    SizedBox(height: 130.h),
                    Align(
                      alignment: .centerEnd,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Social Security Number'),
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
