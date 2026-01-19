import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const _voxApiKey = "voxApiKey";
  static const _otp = "otp";

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

  /* OTP */
  static String get otp => _preference.getString(_otp) ?? "";
  static set otp(String value) => _preference.setString(_otp, value);
}
