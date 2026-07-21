import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staffing/app/constants/app_assets.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/services/auth_prefs_service.dart';
import 'package:staffing/app/services/network_service.dart';
import 'package:staffing/features/common_features/views/no_internet_view.dart';
import 'package:staffing/features/home_main_nav_holder_features/views/home_main_nav_holder_view.dart';
import 'package:staffing/features/welcome_features/views/get_started_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _showNoInternet = false;

  @override
  void initState() {
    // TODO: implement initState
    _startApp();
    NetworkService.instance.connectionStream.listen((event) async {
      if (mounted) {
        setState(() {
          _showNoInternet = event == false;
        });
      }
      if (_showNoInternet == false) {
        final token = await AuthPrefsService().getToken();

        if (!mounted) return;

        if (token != null) {
          if (mounted) context.pushReplacement(const HomeMainNavHolderView());
        } else {
          if (mounted) context.pushReplacement(const GetStartedView());
        }
      }
    });

    super.initState();
  }

  Future<void> _startApp() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    if (_showNoInternet) return NoInternetView(onRetry: _startApp);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset(AppAssets.logo, width: 192.w),
            SizedBox(height: 20.h),
            SizedBox(width: 80.w, child: LinearProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
