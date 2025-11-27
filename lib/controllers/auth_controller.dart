import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';

class AuthController with ChangeNotifier {
  final UserRepository _repo = UserRepository();

  Map<String, dynamic>? currentUser;

  Future<String?> register(String name, String email, String password) async {
    final error = await _repo.register(name, email, password);
    if (error != null) return error;

    currentUser = {"name": name, "email": email};
    notifyListeners();
    return null;
  }

  Future<String?> login(String email, String password) async {
    final error = await _repo.login(email, password);
    if (error != null) return error;

    currentUser = {"email": email};
    notifyListeners();
    return null;
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
