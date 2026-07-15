import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/services/auth_prefs_service.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/forgot_password_features/views/forgot_password_view.dart';
import 'package:staffing/features/home_main_nav_holder_features/views/home_main_nav_holder_view.dart';
import 'package:staffing/features/register_features/views/register_view.dart';

class LoginViews extends StatelessWidget {
  const LoginViews({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailTEC = TextEditingController();
    TextEditingController passwordTEC = TextEditingController();
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
                  SizedBox(height: 40.h),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff000000),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Consumer<LoginViewModel>(
                    builder: (context, provider, child) => Form(
                      key: formKey,
                      child: Column(
                        children: [
                          customTextFieldWidget(
                            validator: (p0) => p0!.isEmpty
                                ? 'Email is required'
                                : RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                    caseSensitive: false,
                                  ).hasMatch(p0)
                                ? null
                                : 'Enter a valid email address',
                            label: 'Email',
                            controller: emailTEC,
                            textInputType: .emailAddress,
                            placeHolder: 'Enter your email',
                            prefixIcon: Icons.email_outlined,
                          ),
                          SizedBox(height: 16.h),
                          customTextFieldWidget(
                            validator: (p0) =>
                                p0!.isEmpty ? 'Password is required' : null,
                            label: 'Password',
                            controller: passwordTEC,
                            textInputType: .text,
                            placeHolder: 'Enter your password',
                            prefixIcon: Icons.lock_outline_sharp,
                            obscureText: provider.isObscure,
                            suffixIcon: provider.isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            onSuffixTap: () {
                              provider.toggleObscure();
                            },
                          ),
                          SizedBox(height: 8.h),
                          Align(
                            alignment: .centerEnd,
                            child: TextButton(
                              onPressed: () {
                                context.push(ForgotPasswordView());
                              },
                              child: Text('Forgot password?'),
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Consumer<LoginViewModel>(
                            builder: (context, provider, child) => Visibility(
                              visible: provider.isLoading == false,
                              replacement: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              child: customElevatedButtonWidget(
                                text: 'Login',
                                onTapped: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (formKey.currentState!.validate() ==
                                      false) {
                                    return;
                                  }
                                  NetworkResponseModel responseModel =
                                      await provider.login(
                                        email: emailTEC.text.trim(),
                                        password: passwordTEC.text.trim(),
                                      );
                                  if (responseModel.isSuccess) {
                                    await AuthPrefsService().saveToken(
                                      responseModel
                                          .responseData['data']['access'],
                                    );
                                    await AuthPrefsService().saveRefreshToken(
                                      responseModel
                                          .responseData['data']['refresh'],
                                    );
                                    context.push(HomeMainNavHolderView());
                                  } else {
                                    showStatusSnackbar(
                                      context,
                                      message:
                                          responseModel.message ??
                                          'Login failed',
                                      type: .error,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push(RegisterView());
                                    },
                                  text: 'Register now',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.themeColor,
                                  ),
                                ),
                              ],
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
    );
  }
}
