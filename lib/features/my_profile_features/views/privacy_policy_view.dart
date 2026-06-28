import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                data: """
      <html>
      <head>
        <title>Privacy Policy</title>
        <style>
          body { font-family: Arial, sans-serif; padding: 16px; line-height: 1.6; }
          h1, h2 { color: #1E3A8A; }
          p { margin-bottom: 12px; }
          ul { margin-left: 20px; }
        </style>
      </head>
      <body>
        <p>We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our application.</p>
      
        <h2>Information We Collect</h2>
        <ul>
          <li>Personal details such as name, email address, and phone number.</li>
          <li>Usage data including app interactions and preferences.</li>
          <li>Device information such as operating system and browser type.</li>
        </ul>
      
        <h2>How We Use Your Information</h2>
        <p>Your information is used to:</p>
        <ul>
          <li>Provide and improve our services.</li>
          <li>Communicate updates, promotions, and support messages.</li>
          <li>Ensure security and prevent fraud.</li>
        </ul>
      
        <h2>Data Sharing</h2>
        <p>We do not sell your personal data. Information may be shared with trusted third‑party providers only to deliver essential services.</p>
      
        <h2>Your Rights</h2>
        <p>You have the right to access, update, or delete your personal information. Please contact us if you wish to exercise these rights.</p>
      
        <h2>Contact Us</h2>
        <p>If you have any questions about this Privacy Policy, please email us at <a href="mailto:support@example.com">support@example.com</a>.</p>
      </body>
      </html>
      
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
