import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static late SharedPreferences _preferences;
  static late PrefService _instance;

  static Future<PrefService> getInstance() async {
    _instance = PrefService();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  void setUserData({
    required Map<String, dynamic> data,
  }) {
    _preferences.setString('userData', json.encode(data));
  }

  String get userToken => _preferences.getString('userToken') ?? '';
  set userToken(String value) => _preferences.setString('userToken', value);
  bool get viewOnboarding => _preferences.getBool('viewOnboarding') ?? false;
  set viewOnboarding(bool value) =>
      _preferences.setBool('viewOnboarding', value);
  bool get sound => _preferences.getBool('sound') ?? false;
  set sound(bool value) => _preferences.setBool('sound', value);

  bool get userGuid => _preferences.getBool('userGuid') ?? false;
  set userGuid(bool value) => _preferences.setBool('userGuid', value);
}
