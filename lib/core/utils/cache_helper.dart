
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/login/models/login_model.dart';

class CacheHelper {
  static late SharedPreferences _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static Future<bool> checkFirstSeen( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? true);

    return seen;
  }
  static Future<void> markAsNotFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', false);
  }



  static String getToken() {
    return _prefs.getString("token") ?? "";
  } static  setToken(String token) {
    return _prefs.setString("token" , token);
  }

  static Future removeLoginData() async {
    await _prefs.clear();
  }
}
