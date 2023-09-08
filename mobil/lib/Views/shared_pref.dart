import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> initialize() async {
    if (_prefs != null) {
      return _prefs!;
    } else {
      _prefs = await SharedPreferences.getInstance();
      return _prefs!;
    }
  }

  static Future<void> saveMail(String mail) async {
    SharedPreferences prefs = await initialize();
    await prefs.setString('mail', mail);
  }

  static Future<void> savePassword(String password) async {
    SharedPreferences prefs = await initialize();
    await prefs.setString('password', password);
  }

  static Future<void> sharedClear() async {
    SharedPreferences prefs = await initialize();
    await prefs.clear();
  }

  static Future<void> login() async {
    SharedPreferences prefs = await initialize();
    await prefs.setBool('login', true);
  }

  static Future get getMail async {
    SharedPreferences prefs = await initialize();
    return prefs.getString('mail') ?? '';
  }

  static Future get getPassword async {
    SharedPreferences prefs = await initialize();
    return prefs.getString('password') ?? '';
  }
}
