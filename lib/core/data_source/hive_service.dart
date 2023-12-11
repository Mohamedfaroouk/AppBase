import 'package:hive_flutter/adapters.dart';

class HiveService {
  //init
  Future<void> init() async {
    await Hive.initFlutter();
  }

  // save notifications in hive
  static Future<void> saveNotification(Map<String, dynamic> data) async {
    final box = await Hive.openBox('notifications');
    await box.add(data);
    // close
    await box.close();
  }

  // get notifications from hive
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final box = await Hive.openBox('notifications');
    List<Map<String, dynamic>> notifications = [];
    for (var i = 0; i < box.length; i++) {
      notifications.add(Map.from(box.getAt(i)));
    }
    // close
    await box.close();
    return notifications;
  }

  //clear notifications
  static Future<void> clearNotifications() async {
    final box = await Hive.openBox('notifications');
    await box.clear();
    // close
    await box.close();
  }
}
