import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:efatorh/core/data_source/hive_service.dart';

import 'notification_manger.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage data) async {
  await HiveService().init();
  NotificationManger.showNotify(data);
  HiveService.saveNotification({
    "title": data.data["title"] ?? data.notification?.title,
    "body": data.data["body"] ?? data.notification?.body,
  });
}

class FcmNotification {
//
  static String deviceToken = "";

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  init() async {
    NotificationManger().init();

    print("FirebaseMessaging.instance.getToken() ${await FirebaseMessaging.instance.getToken()}");

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    listenToNotification();
  }

  void listenToNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage data) async {
      if (Platform.isAndroid) NotificationManger.showNotify(data);
      HiveService.saveNotification({
        "title": data.data["title"] ?? data.notification?.title,
        "body": data.data["body"] ?? data.notification?.body,
      });

      print('on message ${data.toMap()}');
      print('on message notification body ${data.notification?.body}');
      print('on message notification title ${data.notification?.title}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
      print('on Opened ${data.data}');
    });
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
