import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/register_features/view_models/register_view_model.dart';
import 'package:staffing/features/register_features/views/register_step_4_view.dart';
import 'package:staffing/features/register_features/widgets/document_upoload_field_widget.dart';
import 'package:staffing/features/register_features/widgets/step_indicator_widget.dart';

class RegisterStep3View extends StatelessWidget {
  const RegisterStep3View({super.key});

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
                  child: StepIndicatorWidget(totalSteps: 5, currentStep: 2),
                ),
                SizedBox(height: 24.h),
                Consumer<RegisterViewModel>(
                  builder: (context, provider, child) => Form(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        DocumentUpoloadFieldWidget(
                          label: 'Social Security Card',
                          onFileSelected: (file) {
                            provider.socialSecurityCard = file;
                            debugPrint(
                              "Social Security Card picked: ${file?.name}",
                            );
                          },
                        ),
                        DocumentUpoloadFieldWidget(
                          label: 'Nursing License',
                          onFileSelected: (file) {
                            provider.nursingLicense = file;
                            debugPrint("Nursing License: ${file?.name}");
                          },
                        ),
                        DocumentUpoloadFieldWidget(
                          label: 'Physical Examination',
                          onFileSelected: (file) {
                            provider.physicalExamination = file;
                            debugPrint("Physical Examination: ${file?.name}");
                          },
                        ),
                        SizedBox(height: 40.h),
                        customElevatedButtonWidget(
                          text: 'Continue',
                          onTapped: () {
                            context.push(RegisterStep4View());
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
