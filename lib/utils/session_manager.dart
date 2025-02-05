import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> saveAdminData(Map<String, dynamic> admin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('adminData', jsonEncode(admin));
  }

  static Future<Map<String, dynamic>?> getAdminData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? adminJson = prefs.getString('adminData');

    if (adminJson != null) {
      return jsonDecode(adminJson);
    }
    return null;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  }
}
