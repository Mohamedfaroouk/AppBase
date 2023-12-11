import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManger {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );
  static AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

  init() async {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: ((details) async {}));
  }

  static showNotify(RemoteMessage data) {
    flutterLocalNotificationsPlugin.show(
        1,
        data.data["title"] ?? data.notification?.title,
        data.data["body"] ?? data.notification?.body,
        NotificationDetails(
            android: AndroidNotificationDetails(data.notification?.android?.channelId ?? "", "efatorh",
                importance: Importance.high,
                priority: Priority.high,
                playSound: true,
                enableVibration: true,
                channelAction: AndroidNotificationChannelAction.createIfNotExists,
                sound: (data.notification?.android?.sound != "default" && data.notification?.android?.sound != null)
                    ? RawResourceAndroidNotificationSound(data.notification?.android?.sound ?? 'default')
                    : null),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              categoryIdentifier: data.category,
            )));
  }
}
