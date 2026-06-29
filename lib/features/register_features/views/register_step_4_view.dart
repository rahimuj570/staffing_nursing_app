import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/register_features/view_models/register_view_model.dart';
import 'package:staffing/features/register_features/views/register_step_5_view.dart';
import 'package:staffing/features/register_features/widgets/custom_radio_option_widget.dart';
import 'package:staffing/features/register_features/widgets/step_indicator_widget.dart';

class RegisterStep4View extends StatelessWidget {
  const RegisterStep4View({super.key});

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
                Center(
                  child: Image.asset(AppAssets.logoTransparemt, width: 182.w),
                ),
                SizedBox(height: 36.h),
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 20.sp, fontWeight: .w700),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: StepIndicatorWidget(totalSteps: 5, currentStep: 3),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Are you interested in participating in our Housing Program?',
                  style: TextStyle(fontSize: 14.sp, fontWeight: .w600),
                ),
                SizedBox(height: 10.h),
                Consumer<RegisterViewModel>(
                  builder: (context, provider, child) => Form(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        CustomRadioOptionWidget<bool>(
                          value: true,
                          groupValue: provider.isIntersetInHousingProgram,
                          label: 'Yes',
                          onChanged: (value) {
                            provider.changeIsIntersetInHousingProgram(value!);
                          },
                        ),
                        CustomRadioOptionWidget<bool>(
                          value: false,
                          groupValue: provider.isIntersetInHousingProgram,
                          label: 'No',
                          onChanged: (value) {
                            provider.changeIsIntersetInHousingProgram(value!);
                          },
                        ),
                        SizedBox(height: 40.h),
                        customElevatedButtonWidget(
                          text: 'Continue',
                          onTapped: () {
                            context.push(RegisterStep5View());
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
