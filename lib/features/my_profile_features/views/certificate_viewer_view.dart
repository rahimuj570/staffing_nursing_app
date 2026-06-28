import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:staffing/app/constants/app_colors.dart';
import 'package:staffing/features/common_features/widgets/custom_elevated_button_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CertificateViewerView extends StatelessWidget {
  final String title;
  const CertificateViewerView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: .symmetric(horizontal: 20.0.w),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  text: 'Status: ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: .w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Active',
                      style: TextStyle(fontWeight: .normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  text: 'Expiration: ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: .w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Dec 15, 2027',
                      style: TextStyle(fontWeight: .normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                clipBehavior: .hardEdge,
                decoration: BoxDecoration(
                  borderRadius: .circular(12.r),
                  border: .all(width: 2, color: AppColors.themeColorLight),
                ),
                width: .maxFinite,
                height: 400.h,
                child: buildFilePreview('https://pdfobject.com/pdf/sample.pdf'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: .symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customElevatedButtonWidget(
                backgroundColor: Colors.white,
                forgroundColor: AppColors.themeColor,
                borderColor: AppColors.themeColor,
                text: 'Replace',
                onTapped: () {},
                icon: Icons.edit_outlined,
              ),
              SizedBox(height: 12.h),
              customElevatedButtonWidget(
                backgroundColor: Colors.white,
                forgroundColor: AppColors.themeColor,
                borderColor: AppColors.themeColor,
                text: 'Delete',
                onTapped: () {},
                icon: RemixIcons.delete_bin_7_line,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilePreview(String url) {
    if (url.endsWith('.jpg') || url.endsWith('.png')) {
      return ClipRRect(
        borderRadius: .circular(12.r),
        child: Image.network(url, fit: BoxFit.cover),
      );
    } else if (url.endsWith('.pdf')) {
      return ClipRRect(
        borderRadius: .circular(12.r),
        child: SfPdfViewer.network(url),
      );
    } else {
      return Icon(Icons.insert_drive_file, size: 40, color: Colors.grey);
    }
  }
}
