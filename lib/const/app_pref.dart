import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const _voxApiKey = "voxApiKey";

  static late SharedPreferences _preference;

  static DateTime now = DateTime.now();

  void reloadPreference() async {
    await _preference.reload();
  }

  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  static Future<void> clear() async {
    await _preference.clear();
  }

  static String get voxApiKey => _preference.getString(_voxApiKey) ?? "";
  static set voxApiKey(String value) => _preference.setString(_voxApiKey, value);
}
