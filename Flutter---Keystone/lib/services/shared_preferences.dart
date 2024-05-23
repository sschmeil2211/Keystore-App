import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences{

  static final AppSharedPreferences _instance = AppSharedPreferences._internal();

  factory AppSharedPreferences() => _instance;

  AppSharedPreferences._internal();

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}