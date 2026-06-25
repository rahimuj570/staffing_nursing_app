import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/register_features/view_models/register_view_model.dart';
import 'package:staffing/features/register_features/views/register_step_2_view.dart';
import 'package:staffing/features/register_features/widgets/step_indicator_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
                  child: StepIndicatorWidget(totalSteps: 5, currentStep: 0),
                ),
                SizedBox(height: 24.h),
                Consumer<RegisterViewModel>(
                  builder: (context, provider, child) => Form(
                    child: Column(
                      children: [
                        customTextFieldWidget(
                          prefixIcon: Icons.person_2_outlined,
                          label: 'Name',
                          controller: provider.nameTEC,
                          textInputType: .text,
                          placeHolder: 'Enter your name',
                        ),
                        SizedBox(height: 16.h),
                        customTextFieldWidget(
                          prefixIcon: Icons.local_phone,
                          label: 'Phone',
                          controller: provider.phoneTEC,
                          textInputType: .phone,
                          placeHolder: 'Enter your phone number',
                        ),
                        SizedBox(height: 16.h),
                        customTextFieldWidget(
                          prefixIcon: Icons.email_outlined,
                          label: 'Email',
                          controller: provider.emailTEC,
                          textInputType: .emailAddress,
                          placeHolder: 'Enter your email',
                        ),
                        SizedBox(height: 16.h),
                        customTextFieldWidget(
                          prefixIcon: Icons.lock_outline_rounded,
                          label: 'Password',
                          controller: provider.passwordTEC,
                          textInputType: .text,
                          placeHolder: 'Create password',
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
                          controller: provider.confirmPasswordTEC,
                          textInputType: .text,
                          placeHolder: 'Confirm password',
                          suffixIcon: provider.confirmPasswordObsecure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          obscureText: provider.confirmPasswordObsecure,
                          onSuffixTap: () =>
                              provider.changeConfirmPasswordObsecure(),
                        ),
                        SizedBox(height: 16.h),
                        customTextFieldWidget(
                          prefixIcon: Icons.location_on_outlined,
                          label: 'Address',
                          controller: provider.addtessTEC,
                          textInputType: .text,
                          placeHolder: 'Enter your address',
                        ),
                        SizedBox(height: 16.h),
                        customTextFieldWidget(
                          prefixIcon: Icons.numbers_rounded,
                          label: 'SSN',
                          controller: provider.addtessTEC,
                          textInputType: .text,
                          placeHolder: 'Enter Social Security Number',
                        ),
                        SizedBox(height: 40.h),
                        customElevatedButtonWidget(
                          text: 'Continue',
                          onTapped: () {
                            context.push(const RegisterStep2View());
                          },
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: .w400,
                                color: AppColors.greyColor,
                              ),
                            ),
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: .w600,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
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
