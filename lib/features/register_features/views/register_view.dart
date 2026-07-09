import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
import 'package:staffing/features/register_features/view_models/register_user_view_model.dart';
import 'package:staffing/features/register_features/views/register_user_otp_vefication_view.dart';
import 'package:staffing/features/register_features/widgets/step_indicator_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();
  TextEditingController addtessTEC = TextEditingController();
  TextEditingController ssnTEC = TextEditingController();
  PlatformFile? _profilePic;

  Future<PlatformFile?> _pickProfilePicture() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      //all type of image extension should be allowed
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      _profilePic = result.files.first;
      setState(() {});
    }
    return _profilePic;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameTEC.dispose();
    emailTEC.dispose();
    phoneTEC.dispose();
    passwordTEC.dispose();
    confirmPasswordTEC.dispose();
    addtessTEC.dispose();
    ssnTEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                    child: StepIndicatorWidget(totalSteps: 4, currentStep: 0),
                  ),
                  SizedBox(height: 24.h),
                  Consumer<RegisterUserViewModel>(
                    builder: (context, provider, child) => Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          customTextFieldWidget(
                            validator: (p0) =>
                                p0!.isEmpty ? 'Need to fill this field.' : null,

                            prefixIcon: Icons.person_2_outlined,
                            label: 'Name',
                            controller: nameTEC,
                            textInputType: .text,
                            placeHolder: 'Enter your name',
                          ),
                          SizedBox(height: 16.h),
                          customTextFieldWidget(
                            validator: (p0) =>
                                p0!.isEmpty ? 'Need to fill this field.' : null,
                            prefixIcon: Icons.local_phone,
                            label: 'Phone',
                            controller: phoneTEC,
                            textInputType: .phone,
                            placeHolder: 'Enter your phone number',
                          ),
                          SizedBox(height: 16.h),
                          customTextFieldWidget(
                            validator: (p0) =>
                                p0!.isEmpty ? 'Need to fill this field.' : null,
                            prefixIcon: Icons.email_outlined,
                            label: 'Email',
                            controller: emailTEC,
                            textInputType: .emailAddress,
                            placeHolder: 'Enter your email',
                          ),
                          SizedBox(height: 16.h),
                          customTextFieldWidget(
                            validator: (p0) =>
                                p0!.isEmpty ? 'Need to fill this field.' : null,
                            prefixIcon: Icons.lock_outline_rounded,
                            label: 'Password',
                            controller: passwordTEC,
                            textInputType: .text,
                            placeHolder: 'Create password',
                            suffixIcon: provider.passwordObsecure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            obscureText: provider.passwordObsecure,
                            onSuffixTap: () =>
                                provider.changePasswordObsecure(),
                          ),
                          SizedBox(height: 16.h),
                          customTextFieldWidget(
                            onChanged: (p0) {
                              print("$p0---------${passwordTEC.text}");
                              if (p0 != passwordTEC.text) {
                                return 'Password does not match';
                              } else {
                                return null;
                              }
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Need to fill this field.';
                              } else if (p0 != passwordTEC.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                            prefixIcon: Icons.lock_outline_rounded,
                            label: 'Confirm Password',
                            controller: confirmPasswordTEC,
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
                            validator: (p0) =>
                                p0!.isEmpty ? 'Need to fill this field.' : null,
                            prefixIcon: Icons.location_on_outlined,
                            label: 'Address',
                            controller: addtessTEC,
                            textInputType: .text,
                            placeHolder: 'Enter your address',
                          ),
                          SizedBox(height: 16.h),
                          customTextFieldWidget(
                            validator: (p0) =>
                                p0!.isEmpty ? 'Need to fill this field.' : null,
                            prefixIcon: Icons.numbers_rounded,
                            label: 'SSN',
                            controller: ssnTEC,
                            textInputType: .text,
                            placeHolder: 'Enter Social Security Number',
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Profile Picture',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: .w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          GestureDetector(
                            onTap: () => _pickProfilePicture(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: .circular(12.r),
                                border: .all(
                                  width: 1.5.w,
                                  color: AppColors.themeColor,
                                ),
                              ),
                              width: .maxFinite,
                              child: Padding(
                                padding: .all(50.r),
                                child: Center(
                                  child: (_profilePic != null)
                                      ? Image.file(
                                          File(_profilePic!.path!),
                                          width: .infinity,
                                          fit: .contain,
                                        )
                                      : Column(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 24.r,
                                              color: AppColors.greyColor,
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              'Upload your picture',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: .w600,
                                                color: AppColors.greyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Visibility(
                            visible: provider.isLoading == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: customElevatedButtonWidget(
                              text: 'Continue',
                              onTapped: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_profilePic == null) {
                                    showStatusSnackbar(
                                      context,
                                      message:
                                          'Please upload your profile picture.',
                                      type: .warning,
                                    );
                                  } else {
                                    NetworkResponseModel
                                    response = await provider.registerUser(
                                      email: emailTEC.text,
                                      password: passwordTEC.text,
                                      passwordConfirm: confirmPasswordTEC.text,
                                      address: addtessTEC.text,
                                      ssn: ssnTEC.text,
                                      name: nameTEC.text,
                                      phone: phoneTEC.text,
                                      profilePicture: File(_profilePic!.path!),
                                    );

                                    if (response.isSuccess) {
                                      showStatusSnackbar(
                                        context,
                                        message: 'Registration successful.',
                                        type: .success,
                                      );
                                      // context.pop();
                                      context.push(
                                        RegisterUserOtpVeficationView(
                                          email: emailTEC.text,
                                        ),
                                      );
                                    } else {
                                      showStatusSnackbar(
                                        context,
                                        message:
                                            response.message ??
                                            'Registration failed.',
                                        type: .error,
                                      );
                                    }
                                  }
                                }
                              },
                            ),
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
      ),
    );
  }
}
