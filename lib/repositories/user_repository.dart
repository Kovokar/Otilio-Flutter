import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

class UserRepository {
  final _box = Hive.box('users');

  /// Gera hash seguro da senha
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  /// Cadastro simples
  Future<String?> register(String name, String email, String password) async {
    if (_box.containsKey(email)) {
      return "Email já cadastrado";
    }

    final hashed = _hashPassword(password);

    _box.put(email, {
      "name": name,
      "email": email,
      "password": hashed,
    });

    return null; // sucesso
  }

  /// Login simples
  Future<String?> login(String email, String password) async {
    if (!_box.containsKey(email)) {
      return "Email não encontrado";
    }

    final user = _box.get(email);
    final hashed = _hashPassword(password);

    if (user["password"] != hashed) {
      return "Senha incorreta";
    }

    return null; // sucesso
  }
}
