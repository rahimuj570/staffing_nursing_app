import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:staffing/app/app.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/extensions/route.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/services/auth_prefs_service.dart';
import 'package:staffing/features/common_features/views/shift_details_view.dart';
import 'package:staffing/features/home_main_nav_holder_features/view_models/main_home_nav_holder_view_model.dart';
import 'package:staffing/features/home_main_nav_holder_features/views/home_main_nav_holder_view.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  /////////////REQUEST PERMISSION///////////////
  ///
  Future<void> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log('Permission: ${settings.authorizationStatus}');
  }

  //////////////////GET FIREBASE TOKEN///////////////
  ///
  Future<String> getToken() async {
    final token = await _firebaseMessaging.getToken();

    log('FCM Token: $token');
    return token ?? '';
  }

  ////////////////// FIREBASE TOKEN CHANGES///////////////
  ///
  void listenTokenRefresh() {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      log('New FCM Token: $token');

      sendToken(token);
    });
  }

  ///////////////////SEND FIREBASE FCM TOKEN///////////////
  ///
  Future<void> sendToken(String token) async {
    await ApiService.post(
      UrlList.fcmToken,
      data: {"registration_id": token, "is_active": true},
    );
  }

  /////////////////////INITIALIZE LOCAL NOTIFICATION///////////
  ///
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('payload: ${response.payload}'); //to get payload response.data);
        if (response.payload != null) {
          handleNotificationTap(jsonDecode(response.payload!));
        }
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
  }

  ///////////////////SHOW LOCAL NOTIFICATION/////////////
  ///
  Future<void> showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification == null || android == null) {
      return;
    }

    await _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  ///////////////////LISTER FIREBASE FORGROUND MESSAGE/////////////
  ///
  void setupForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground Message Received');
      log('Title: ${message.notification?.title}');
      log('Body: ${message.notification?.body}');
      log('Data: ${message.data}');

      showLocalNotification(message);
    });
  }

  ///////////////////INITIALIZER/////////////
  ///
  Future<void> initialize() async {
    await requestPermission();
    await initializeLocalNotifications();
    await getToken();

    listenTokenRefresh();
    setupForegroundListener();
  }

  ////////////////////NAVIGATOR PAGE ON NOTIFICATION TAP///////////
  ///
  //   > | Event | Data Payload | What you should do |
  // > | :--- | :--- | :--- |
  // > | Profile Approved | `{"type": "profile_approved"}` | Route to Dashboard/Home |
  // > | Profile Rejected | `{"type": "profile_rejected"}` | Route to Profile/Support screen |
  // > | Shift Accepted | `{"type": "shift_accepted", "shift_id": "123"}` | Route to Upcoming Shifts |
  // > | Shift Rejected | `{"type": "shift_rejected", "shift_id": "123"}` | Route to Shift Details |
  // > | Shift Cancelled | `{"type": "shift_cancelled", "shift_id": "123"}` | Route to Dashboard |

  void handleNotificationTap(Map<String, dynamic> data) {
    // Map<String, dynamic> data = jsonDecode(payload);
    BuildContext context = MainAppScreen.navigatorKey.currentContext!;
    print('ssssssssssssssssssssssss data: ${data['type']}');
    if (data['type'] == 'profile_approved') {
      context.pushRemoveUntil(HomeMainNavHolderView());
    } else if (data['type'] == 'profile_rejected') {
      AuthPrefsService().removeToken();
    } else if (data['type'] == 'shift_accepted') {
      log('Shift ID: ${data['shift_id']}');
      context.read<MainHomeNavHolderViewModel>().changeIndex(2);
      context.push(HomeMainNavHolderView());
    } else if (data['type'] == 'shift_rejected') {
      log('Shift ID: ${data['shift_id']} on rejected');
      context.push(
        ShiftDetailsView(
          id: int.parse(data['shift_id']),
          isScheduleDetails: true,
          status: 'REJECTED',
        ),
      );
    } else if (data['type'] == 'shift_cancelled') {
      context.push(HomeMainNavHolderView());
    }
  }
}
