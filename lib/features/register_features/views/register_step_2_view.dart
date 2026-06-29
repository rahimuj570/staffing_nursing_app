import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/register_features/view_models/register_view_model.dart';
import 'package:staffing/features/register_features/views/register_step_3_view.dart';
import 'package:staffing/features/register_features/widgets/nurse_type_card_widget.dart';
import 'package:staffing/features/register_features/widgets/step_indicator_widget.dart';

class RegisterStep2View extends StatelessWidget {
  const RegisterStep2View({super.key});

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
                  child: StepIndicatorWidget(totalSteps: 5, currentStep: 1),
                ),
                SizedBox(height: 24.h),
                Consumer<RegisterViewModel>(
                  builder: (context, provider, child) => Form(
                    child: Column(
                      children: [
                        NurseTypeCardWidget(
                          title: 'CNA',
                          subtitle: 'Certified Nursing Assistant',
                          icon: const Icon(
                            Icons.medical_services_outlined,
                            size: 36,
                          ), // Swap with Image.asset if needed
                          isSelected: provider.nurseType == 'CNA',
                          onTap: () => provider.changeNurseType('CNA'),
                        ),

                        NurseTypeCardWidget(
                          title: 'LPN',
                          subtitle: 'Licensed Practical Nurse',
                          icon: const Icon(
                            Icons.local_hospital_outlined,
                            size: 36,
                          ),
                          isSelected: provider.nurseType == 'LPN',
                          onTap: () => provider.changeNurseType('LPN'),
                        ),

                        NurseTypeCardWidget(
                          title: 'RN',
                          subtitle: 'Registered Nurse',
                          icon: const Icon(
                            Icons.health_and_safety_outlined,
                            size: 36,
                          ),
                          isSelected: provider.nurseType == 'RN',
                          onTap: () => provider.changeNurseType('RN'),
                        ),

                        customTextFieldWidget(
                          label: '',
                          controller: provider.experienceTEC,
                          textInputType: .text,
                          placeHolder: 'Years of Experience',
                        ),
                        SizedBox(height: 16.h),
                        customTextFieldWidget(
                          label: '',
                          controller: provider.stateLicenseNumberTEC,
                          textInputType: .phone,
                          placeHolder: 'State License Number',
                        ),
                        SizedBox(height: 16.h),

                        SizedBox(height: 40.h),
                        customElevatedButtonWidget(
                          text: 'Continue',
                          onTapped: () {
                            context.push(const RegisterStep3View());
                          },
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
