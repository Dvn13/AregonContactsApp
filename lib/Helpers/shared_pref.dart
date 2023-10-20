import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferencesManager _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesManager._();

  static Future<SharedPreferencesManager> getInstance() async {
    _instance = SharedPreferencesManager._();
    _preferences = await SharedPreferences.getInstance();

    return _instance;
  }

  Future<String> getEmail() async {
    return _preferences.getString('email') ?? '';
  }

  Future<void> setEmail(String email) async {
    await _preferences.setString('email', email);
  }
}
