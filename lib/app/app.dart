import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/app_theme.dart';
import 'package:staffing/app/services/auth_logout_event_bus.dart';
import 'package:staffing/app/services/network_service.dart';
import 'package:staffing/features/auth_features/view_models/login_view_model.dart';
import 'package:staffing/features/auth_features/views/login_views.dart';
import 'package:staffing/features/common_features/view_models/notification_view_model.dart';
import 'package:staffing/features/forgot_password_features/view_models/forgot_password_view_model.dart';
import 'package:staffing/features/home_features/view_models/home_view_model.dart';
import 'package:staffing/features/home_main_nav_holder_features/view_models/main_home_nav_holder_view_model.dart';
import 'package:staffing/features/my_profile_features/view_models/document_view_model.dart';
import 'package:staffing/features/my_profile_features/view_models/leader_board_view_model.dart';
import 'package:staffing/features/my_profile_features/view_models/my_profile_view_model.dart';
import 'package:staffing/features/register_features/view_models/register_user_view_model.dart';
import 'package:staffing/features/register_features/view_models/register_view_model.dart';
import 'package:staffing/features/schedule_features/view_models/schedule_view_model.dart';
import 'package:staffing/features/shift_features/view_models/shift_view_model.dart';
import 'package:staffing/features/welcome_features/views/splash_view.dart';

class MainAppScreen extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  bool isNoInternetBannerShowing = false;
  StreamSubscription? _logoutSubscription;

  @override
  void initState() {
    super.initState();
    _logoutSubscription = AuthLogoutEventBus.instance.stream.listen((event) {
      MainAppScreen.navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginViews()),
        ((route) => false),
      );
    });

    NetworkService.instance.initialize();
    NetworkService.instance.connectionStream.listen((event) {
      print('hasInternetMAIN APP: $event');

      if (event == false) {
        if (isNoInternetBannerShowing) return;
        isNoInternetBannerShowing = true;
        MainAppScreen.scaffoldMessengerKey.currentState?.showMaterialBanner(
          MaterialBanner(
            backgroundColor: Colors.red,
            contentTextStyle: const TextStyle(color: Colors.white),
            content: const Text("No Internet Connection"),
            leading: const Icon(Icons.wifi_off, color: Colors.white),
            actions: [
              TextButton(
                onPressed: () async {
                  final hasInternet = await NetworkService.instance
                      .checkConnection();

                  if (hasInternet) {
                    isNoInternetBannerShowing = false;
                    MainAppScreen.scaffoldMessengerKey.currentState
                        ?.hideCurrentMaterialBanner();
                    NetworkService.instance.onRetry?.call();
                  }
                },
                child: const Text(
                  "Retry",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      } else {
        isNoInternetBannerShowing = false;
        MainAppScreen.scaffoldMessengerKey.currentState
            ?.hideCurrentMaterialBanner();
        NetworkService.instance.onRetry?.call();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _logoutSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => MainHomeNavHolderViewModel()),
        ChangeNotifierProvider(create: (_) => ScheduleViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterUserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ShiftViewModel()),
        ChangeNotifierProvider(create: (_) => MyProfileViewModel()),
        ChangeNotifierProvider(create: (_) => DocumentViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => LeaderBoardViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(402, 874),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp(
          navigatorKey: MainAppScreen.navigatorKey,
          scaffoldMessengerKey: MainAppScreen.scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme(),
          home: const SplashView(),
        ),
      ),
    );
  }
}
