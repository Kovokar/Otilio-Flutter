import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class StorageService {
  static const _userKey = 'user';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);
    if (raw == null) return null;
    return User.fromJson(jsonDecode(raw));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
  }
}
