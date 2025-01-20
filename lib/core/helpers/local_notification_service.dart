import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponce) {
    streamController.add(notificationResponce);
  }

  static Future<void> init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  static Future<void> showBasicNotification(RemoteMessage message) async {
    AndroidNotificationDetails anroid = AndroidNotificationDetails(
      "id 1",
      'Basic notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = NotificationDetails(
      android: anroid,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: "payloud data",
    );
  }
}
