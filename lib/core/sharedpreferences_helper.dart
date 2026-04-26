import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences preferences;

  static Future startDb() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future saveUsername(String username) async {
    await preferences.setString("username", username);
  }

  static Future setLogin(bool isLogin) async {
    await preferences.setBool("isLogin", isLogin);
  }

  static String? getUserName() {
    return preferences.getString("username");
  }

  static bool? getIsLogin() {
    return preferences.getBool("isLogin");
  }

  static Future clear() async {
    await preferences.clear();
  }
}
