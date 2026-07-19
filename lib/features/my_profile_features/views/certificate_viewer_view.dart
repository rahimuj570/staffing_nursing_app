import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:staffing/features/my_profile_features/view_models/document_view_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CertificateViewerView extends StatelessWidget {
  final String title;
  final String documentType;
  const CertificateViewerView({
    super.key,
    required this.title,
    required this.documentType,
  });

  @override
  Widget build(BuildContext context) {
    String? getFileUrl(String documentType) {
      String? fileUrl;
      if (documentType == 'nursing_license') {
        context
            .read<LoginViewModel>()
            .nurseProfileMeResponseModel
            ?.documents
            ?.forEach((element) {
              if (element.documentType == 'nursing_license') {
                fileUrl = element.file;
              }
            });
      } else if (documentType == 'physical_exam') {
        context
            .read<LoginViewModel>()
            .nurseProfileMeResponseModel
            ?.documents
            ?.forEach((element) {
              if (element.documentType == 'physical_exam') {
                fileUrl = element.file;
              }
            });
      } else {
        context
            .read<LoginViewModel>()
            .nurseProfileMeResponseModel
            ?.documents
            ?.forEach((element) {
              if (element.documentType == 'ssn_card') {
                fileUrl = element.file;
              }
            });
      }
      return fileUrl;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Consumer2<LoginViewModel, DocumentViewModel>(
        builder: (context, loginViewModel, documentViewModel, child) =>
            SingleChildScrollView(
              child: Padding(
                padding: .symmetric(horizontal: 20.0.w),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 20.h),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Status: ',
                    //     style: TextStyle(
                    //       fontSize: 16.sp,
                    //       fontWeight: .w600,
                    //       color: Colors.black,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: 'Active',
                    //         style: TextStyle(fontWeight: .normal),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 8.h),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Expiration: ',
                    //     style: TextStyle(
                    //       fontSize: 16.sp,
                    //       fontWeight: .w600,
                    //       color: Colors.black,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: 'Dec 15, 2027',
                    //         style: TextStyle(fontWeight: .normal),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 24.h),
                    Container(
                      clipBehavior: .hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: .circular(12.r),
                        border: .all(
                          width: 2,
                          color: AppColors.themeColorLight,
                        ),
                      ),
                      width: .maxFinite,
                      height: 400.h,
                      child: buildFilePreview(
                        documentViewModel.isFileExist(documentType)
                            ? null
                            : '${getFileUrl(documentType)}',
                        file: documentViewModel.getFile(documentType),
                        fileType: documentType,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Consumer2<LoginViewModel, DocumentViewModel>(
          builder: (context, loginViewModel, documentViewModel, child) =>
              Padding(
                padding: .symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customElevatedButtonWidget(
                      backgroundColor: Colors.white,
                      forgroundColor: AppColors.themeColor,
                      borderColor: AppColors.themeColor,
                      text: 'Replace',
                      onTapped: () async {
                        FilePickerResult? result = await FilePicker.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: [
                            'jpg',
                            'jpeg',
                            'png',
                            'gif',
                            'svg',
                            'webp',
                            'ico',
                            'bmp',
                            'tiff',
                            'pdf',
                          ],
                        );
                        documentViewModel.localSaveFile(
                          File(result!.files.first.path!),
                          documentType,
                        );
                      },
                      icon: Icons.edit_outlined,
                    ),
                    SizedBox(height: 12.h),
                    if (documentViewModel.isFileExist(documentType))
                      customElevatedButtonWidget(
                        backgroundColor: Colors.white,
                        forgroundColor: AppColors.themeColor,
                        borderColor: AppColors.themeColor,
                        text: 'Cancel Change',
                        onTapped: () {
                          documentViewModel.removeSingleFile(documentType);
                        },
                        icon: RemixIcons.delete_bin_7_line,
                      ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  Widget buildFilePreview(String? url, {String? fileType, File? file}) {
    print("URL: $url");
    print("FILE: ${file?.path}");

    // =========================
    // Preview from Network URL
    // =========================
    if (url != null && url.isNotEmpty) {
      final path = url.toLowerCase();

      if (path.endsWith('.jpg') ||
          path.endsWith('.jpeg') ||
          path.endsWith('.png') ||
          path.endsWith('.gif') ||
          path.endsWith('.bmp') ||
          path.endsWith('.webp') ||
          path.endsWith('.svg') ||
          path.endsWith('.ico') ||
          path.endsWith('.tiff')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.broken_image, size: 60));
            },
          ),
        );
      }

      if (path.endsWith('.pdf')) {
        return SizedBox(
          height: 500.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SfPdfViewer.network(url),
          ),
        );
      }

      return const Center(
        child: Icon(Icons.insert_drive_file, size: 60, color: Colors.grey),
      );
    }

    // =========================
    // Preview from Local File
    // =========================
    if (file != null) {
      print("Exists: ${file.existsSync()}");

      if (!file.existsSync()) {
        return const Center(child: Text("File does not exist."));
      }

      final mimeType = lookupMimeType(file.path);
      print("Mime Type: $mimeType");

      if (mimeType != null && mimeType.startsWith('image/')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            file,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.broken_image, size: 60));
            },
          ),
        );
      }

      if (mimeType == 'application/pdf') {
        return SizedBox(
          height: 500.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SfPdfViewer.file(file),
          ),
        );
      }

      return Center(
        child: Text('No preview available for ${fileType ?? 'this file'}'),
      );
    }

    // =========================
    // Nothing Selected
    // =========================
    return const Center(child: Text('No preview available'));
  }
}
