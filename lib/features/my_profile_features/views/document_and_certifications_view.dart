import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/utils/show_status_snackbar_util.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/my_profile_features/view_models/document_view_model.dart';
import 'package:staffing/features/my_profile_features/views/certificate_viewer_view.dart';
import 'package:staffing/features/my_profile_features/widgets/my_profile_menu_widget.dart';
import 'package:staffing/features/register_features/views/register_successfull_view.dart';

class DocumentAndCertificationsView extends StatelessWidget {
  const DocumentAndCertificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentViewModel>(
      builder: (context, provider, child) => PopScope(
        canPop: provider.isChanged == false,
        onPopInvokedWithResult: (didPop, result) {
          if (provider.isChanged) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Are you sure you want to leave? Any unsaved changes will be lost.',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: customElevatedButtonWidget(
                            text: 'No',
                            onTapped: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: customElevatedButtonWidget(
                            backgroundColor: Colors.red,
                            text: 'Yes',
                            onTapped: () {
                              provider.isChanged = false;
                              provider.clearAll();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Document and Certifications')),
          body: Consumer<DocumentViewModel>(
            builder: (context, provider, child) => provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: .symmetric(horizontal: 20.0.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: .all(16.0.r),
                            child: MytProfileMenuWidget(
                              icon: Icons.text_snippet_outlined,
                              title: 'Social Security Card',
                              onTap: () {
                                context.push(
                                  const CertificateViewerView(
                                    title: 'Social Security Card',
                                    documentType: 'ssn_card',
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: .all(16.0.r),
                            child: MytProfileMenuWidget(
                              icon: Icons.text_snippet_outlined,
                              title: 'Nursing License',
                              onTap: () {
                                context.push(
                                  const CertificateViewerView(
                                    title: 'Nursing License',
                                    documentType: 'nursing_license',
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: .all(16.0.r),
                            child: MytProfileMenuWidget(
                              icon: Icons.text_snippet_outlined,
                              title: 'Physical Examination',
                              onTap: () {
                                context.push(
                                  const CertificateViewerView(
                                    title: 'Physical Examination',
                                    documentType: 'physical_exam',
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        if (provider.isChanged)
                          Visibility(
                            visible: provider.isLoading == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: customElevatedButtonWidget(
                              text: 'Save Changes',
                              onTapped: () async {
                                NetworkResponseModel responseModel =
                                    await provider.updateDocument();

                                if (responseModel.isSuccess) {
                                  showStatusSnackbar(
                                    context,
                                    message: 'Successfully updated',
                                    type: .success,
                                  );

                                  provider.isChanged = false;
                                  provider.clearAll();
                                  await context
                                      .read<LoginViewModel>()
                                      .fetchMe();
                                  context.pushRemoveUntil(
                                    RegisterSuccessfullView(),
                                  );
                                } else {
                                  showStatusSnackbar(
                                    context,
                                    message:
                                        responseModel.message ??
                                        'Failed to update',
                                    type: .error,
                                  );
                                }
                              },
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
