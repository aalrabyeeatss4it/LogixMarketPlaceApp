import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:logix_market_place/services/service_result.dart';

import '../common/api_paths.dart';
import '../common/storage/local_storage.dart';
import '../models/fcm_token_dto.dart';
import 'fcm_service.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _requestPermission();
    await _initLocalNotifications();
    await _setupListeners();
    await _getToken();
  }

  static Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Permission: ${settings.authorizationStatus}');
  }

  static Future<void> _initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(settings);
  }

  static Future<void> _setupListeners() async {
    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.notification?.title}');
      _showNotification(message);
    });

    // Background (app in background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
      // TODO: navigate using Get.to(...)
    });

    // Terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print('Terminated state notification: ${initialMessage.notification?.title}');
      _showNotification(initialMessage);
    }
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    await _localNotifications.show(
      0,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> _getToken() async {
    String? token = await _messaging.getToken();
    print("FCM Token: $token");
    if(token != null){
      FcmTokenDto fcmToken= FcmTokenDto(fcmToken: token);
      sendFcmToken(fcmToken);
    }
  }

  static Future<ServiceResult<dynamic>> sendFcmToken(FcmTokenDto fcmToken) async {

    if(box.read(tokenIndex)!=null){
      Response response = await post(Uri.parse(baseUrl + sendFcmTokenPath),
          body: jsonEncode(fcmToken.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization":'Bearer ' + (box.read(tokenIndex))
          }
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return SuccessStatus<String>(data: json['data'] as String);
      }
      if (response.statusCode == 400) {
        var json = jsonDecode(response.body);
        return FailureStatus(errorMessage: json['message']??'حدث خطأ اثناء تنفيذ الطلب، الرجاء المحاولة مرة اخرى.');
      }
      return FailureStatus(errorMessage: 'حدث خطأ اثناء تنفيذ الطلب، الرجاء المحاولة مرة اخرى.');
    }
    return FailureStatus(errorMessage: 'حدث خطأ اثناء تنفيذ الطلب، الرجاء المحاولة مرة اخرى.');
    }

}