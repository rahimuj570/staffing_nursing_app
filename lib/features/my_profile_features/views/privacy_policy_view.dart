import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/features/my_profile_features/view_models/my_profile_view_model.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Html(
                data:
                    """
      ${context.read<MyProfileViewModel>().myProfileResponseModel?.privacyPolicy}
      
        """,
                extensions: [
                  TagExtension(
                    tagsToExtend: {"flutter"},
                    child: const FlutterLogo(),
                  ),
                ],
                style: {
                  "p.fancy": Style(
                    textAlign: TextAlign.center,
                    padding: .all(16.r),
                    backgroundColor: Colors.grey,
                    margin: Margins(
                      left: Margin(50, Unit.px),
                      right: Margin.auto(),
                    ),
                    width: Width(300, Unit.px),
                    fontWeight: FontWeight.bold,
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
