import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'dart:math';

class AuthController with ChangeNotifier {
  final UserRepository _repo = UserRepository();
  User? currentUser;
  bool loading = false;

  Future<void> login({required String email, required String password}) async {
    loading = true;
    notifyListeners();

    // Simulação simples: cria um usuário e salva
    await Future.delayed(Duration(seconds: 1));
    final user = User(
      id: Random().nextInt(10000).toString(),
      name: 'Usuário',
      email: email,
    );
    await _repo.saveUser(user);
    currentUser = user;

    loading = false;
    notifyListeners();
  }

  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    loading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));
    final user =
        User(id: Random().nextInt(10000).toString(), name: name, email: email);
    await _repo.saveUser(user);
    currentUser = user;

    loading = false;
    notifyListeners();
  }

  Future<void> loadSavedUser() async {
    currentUser = await _repo.getUser();
    notifyListeners();
  }

  Future<void> logout() async {
    await _repo.clear();
    currentUser = null;
    notifyListeners();
  }
}
