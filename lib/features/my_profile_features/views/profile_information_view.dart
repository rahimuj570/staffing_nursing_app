import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/common_features/widgets/custom_text_field_widget.dart';

class ProfileInformationView extends StatefulWidget {
  const ProfileInformationView({super.key});

  @override
  State<ProfileInformationView> createState() => _ProfileInformationViewState();
}

class _ProfileInformationViewState extends State<ProfileInformationView> {
  PlatformFile? image;
  void pickImage() async {
    FilePickerResult? res = await FilePicker.pickFiles();

    if (res != null) {
      image = res.files.first;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTEC = TextEditingController();
    TextEditingController phoneTEC = TextEditingController();
    TextEditingController addressTEC = TextEditingController();
    TextEditingController emailTEC = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Profile Information')),
      body: SingleChildScrollView(
        child: Padding(
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
                          borderRadius: BorderRadius.circular(100.r),
                          child: image == null
                              ? Image.asset(AppAssets.nurseDp, fit: .cover)
                              : Image.file(File(image!.path!), fit: .cover),
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
                      controller: nameTEC,
                      textInputType: .text,
                      placeHolder: 'Shanae Taylor',
                    ),
                    SizedBox(height: 16.h),
                    customTextFieldWidget(
                      label: 'Phone',
                      controller: phoneTEC,
                      textInputType: .phone,
                      placeHolder: "01234512452",
                    ),
                    SizedBox(height: 16.h),
                    customTextFieldWidget(
                      readOnly: true,
                      label: 'Email',
                      controller: emailTEC,
                      textInputType: .emailAddress,
                      placeHolder: 'Shanae Taylor',
                      suffixIcon: RemixIcons.lock_line,
                    ),
                    SizedBox(height: 16.h),
                    customTextFieldWidget(
                      label: 'Address',
                      controller: addressTEC,
                      textInputType: .text,
                      placeHolder: 'Shanae Taylor',
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: .symmetric(horizontal: 20.w),
          child: customElevatedButtonWidget(
            text: 'Save Changes',
            onTapped: () {
              context.pop();
            },
          ),
        ),
      ),
    );
  }
}
