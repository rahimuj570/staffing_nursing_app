import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';
import 'package:staffing/features/my_profile_features/view_models/my_profile_view_model.dart';

class ProfileInformationView extends StatefulWidget {
  const ProfileInformationView({super.key});

  @override
  State<ProfileInformationView> createState() => _ProfileInformationViewState();
}

class _ProfileInformationViewState extends State<ProfileInformationView> {
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _addressTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  PlatformFile? image;
  void pickImage() async {
    FilePickerResult? res = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (res != null) {
      image = res.files.first;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<LoginViewModel>().fetchMe();
      _nameTEC.text =
          context.read<LoginViewModel>().nurseProfileMeResponseModel?.name ??
          '';
      _phoneTEC.text =
          context.read<LoginViewModel>().nurseProfileMeResponseModel?.phone ??
          '';
      _addressTEC.text =
          context.read<LoginViewModel>().nurseProfileMeResponseModel?.address ??
          '';
      _emailTEC.text = context.read<LoginViewModel>().currentUser?.email ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _nameTEC.dispose();
    _phoneTEC.dispose();
    _addressTEC.dispose();
    _emailTEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Information')),
      body: SingleChildScrollView(
        child: Consumer<LoginViewModel>(
          builder: (context, provider, child) => provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: .symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Center(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Stack(
                            children: [
                              Container(
                                width: 112.w,
                                height: 112.h,
                                decoration: BoxDecoration(
                                  shape: .circle,
                                  border: Border.all(
                                    color: AppColors.themeColorLight,
                                    width: 4.w,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(112.r),
                                  child: image == null
                                      ? Image.network(
                                          '${UrlList.baseUrl}${provider.nurseProfileMeResponseModel?.profilePicture}',
                                          fit: .cover,
                                        )
                                      : Image.file(
                                          File(image!.path!),
                                          fit: .cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: 5.h,
                                right: 5.w,
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: .circular(8.r),
                                    color: AppColors.themeColorLight,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    size: 20.r,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Form(
                        child: Column(
                          children: [
                            customTextFieldWidget(
                              label: 'Name',
                              controller: _nameTEC,
                              textInputType: .text,
                              placeHolder: 'Shanae Taylor',
                            ),
                            SizedBox(height: 16.h),
                            customTextFieldWidget(
                              label: 'Phone',
                              controller: _phoneTEC,
                              textInputType: .phone,
                              placeHolder: "01234512452",
                            ),
                            SizedBox(height: 16.h),
                            customTextFieldWidget(
                              readOnly: true,
                              label: 'Email',
                              controller: _emailTEC,
                              textInputType: .emailAddress,
                              placeHolder:
                                  'shanae@gmail.com', // Shanae Taylor',
                              suffixIcon: RemixIcons.lock_line,
                            ),
                            SizedBox(height: 16.h),
                            customTextFieldWidget(
                              label: 'Address',
                              controller: _addressTEC,
                              textInputType: .text,
                              placeHolder:
                                  '1234 Main Street, New York, NY 10001',
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: .symmetric(horizontal: 20.w),
          child: Consumer<MyProfileViewModel>(
            builder: (context, provider, child) => provider.isLoading
                ? SizedBox(
                    height: 50.h,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : customElevatedButtonWidget(
                    text: 'Save Changes',
                    onTapped: () async {
                      NetworkResponseModel responseModel = await context
                          .read<MyProfileViewModel>()
                          .editNurseProfile(
                            image: image == null ? null : File(image!.path!),
                            name: _nameTEC.text,
                            phone: _phoneTEC.text,
                            address: _addressTEC.text,
                          );
                      await context.read<LoginViewModel>().fetchMe();
                      if (responseModel.isSuccess) {
                        showStatusSnackbar(
                          context,
                          message: "Successfully updated profile",
                          type: .success,
                        );
                        context.pop();
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
