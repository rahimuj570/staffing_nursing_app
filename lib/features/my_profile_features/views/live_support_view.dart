import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staffing/features/my_profile_features/view_models/my_profile_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveSupportView extends StatefulWidget {
  const LiveSupportView({super.key});

  @override
  State<LiveSupportView> createState() => _LiveSupportViewState();
}

class _LiveSupportViewState extends State<LiveSupportView> {
  bool loading = true;
  WebViewController? webViewController;

  @override
  void initState() {
    // TODO: implement initState
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse(
          context
                  .read<MyProfileViewModel>()
                  .myProfileResponseModel!
                  .twktoChatLink ??
              '',
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) => NavigationDecision.prevent,
          onPageFinished: (url) {
            setState(() {
              loading = false;
            });
          },
        ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Live Support')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(child: WebViewWidget(controller: webViewController!)),
    );
  }
}
