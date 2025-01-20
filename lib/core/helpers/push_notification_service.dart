import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/local_notification_service.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    NotificationSettings settings = await messaging.requestPermission();

    // Check the permission status
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log('User denied permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('Permission status: ${settings.authorizationStatus}');
    }
    String? token = await messaging.getToken();
    String? token_exists = await CacheHelper.sharedPreferences
        .getString(cacheHelperString.fcm_token_exist);
    log("fcm_token: $token");
    //!!! here you have to more validate if there is internet or not and make more error catching
    // if (token_exists == null) {
    String? role =
        CacheHelper.sharedPreferences.getString(cacheHelperString.role);
    String accessToken = await getAccessToken(getIt<DioConsumer>());
    getIt<DioConsumer>().post(EndPoint.sendFCMtoken, accessToken,
        data: {"fcm_token": token, "role": role}, isFormData: true);

    await CacheHelper.sharedPreferences
        .setString(cacheHelperString.fcm_token_exist, "true");
    // }
    FirebaseMessaging.onBackgroundMessage(handleBackroundMessage);
    handleFourgroundMessage();
  }

  static Future<void> handleBackroundMessage(RemoteMessage message) async {
    await messaging.getToken() == null ? await Firebase.initializeApp() : null;
    log("fcm_token ${message.notification?.title}" ?? "null");
  }

  static void handleFourgroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(message);
    });
  }
}
