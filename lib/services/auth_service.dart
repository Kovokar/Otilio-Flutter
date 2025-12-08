import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Box<dynamic> _authBox;

  Future<void> init() async {
    _authBox = Hive.box('auth');
  }

  // Fazer login e salvar sessão
  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Salvar dados da sessão no Hive
      await _authBox.put('uid', userCredential.user!.uid);
      await _authBox.put('email', userCredential.user!.email);
      await _authBox.put('isLoggedIn', true);

      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Erro ao fazer login";
    }
  }

  // Fazer logout
  Future<void> logout() async {
    await _auth.signOut();
    await _authBox.clear();
  }

  // Verificar se está logado
  bool isLoggedIn() {
    return _authBox.get('isLoggedIn', defaultValue: false) as bool;
  }

  // Obter usuário logado
  String? getLoggedInUserEmail() {
    return _authBox.get('email') as String?;
  }

  // Restaurar sessão automaticamente ao abrir o app
  Future<bool> restoreSession() async {
    if (isLoggedIn()) {
      // Verificar se o token ainda é válido no Firebase
      User? currentUser = _auth.currentUser;
      return currentUser != null;
    }
    return false;
  }
}
