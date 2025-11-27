import 'package:flutter/material.dart';
import '../../core/app_routes.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: _passCtrl,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você chamaria o controller: authController.login(...)
                // Por enquanto navegar para home direto
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: Text('Entrar'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
