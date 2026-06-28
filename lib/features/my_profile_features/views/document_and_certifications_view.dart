import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/features/my_profile_features/views/certificate_viewer_view.dart';
import 'package:staffing/features/my_profile_features/widgets/my_profile_menu_widget.dart';

class DocumentAndCertificationsView extends StatelessWidget {
  const DocumentAndCertificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Document and Certifications')),
      body: Padding(
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
                      const CertificateViewerView(title: 'Nursing License'),
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
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
