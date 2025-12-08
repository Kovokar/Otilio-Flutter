import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../services/auth_service.dart';

class AuthController with ChangeNotifier {
  // SINGLETON
  static final AuthController instance = AuthController._internal();
  factory AuthController() => instance;
  AuthController._internal();

  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  get currentUser => null;

  Future<void> init() async {
    await _authService.init();
    await restoreSession();
  }

  Future<String?> register(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Salvar dados do usuário no Hive
      final usersBox = Hive.box('users');
      await usersBox.put(userCredential.user!.uid, {
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
      });

      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Erro ao registrar";
    }
  }

  Future<String?> login(String email, String password) async {
    final error = await _authService.login(email, password);
    if (error == null) {
      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
    }
    return error;
  }

  Future<void> logout() async {
    await _authService.logout();
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }

  Future<void> restoreSession() async {
    final restored = await _authService.restoreSession();
    if (restored) {
      _isLoggedIn = true;
      _userEmail = _authService.getLoggedInUserEmail();
      notifyListeners();
    }
  }
}
