import 'package:flutter/material.dart';
import '../../core/app_routes.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _emailCtrl,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passCtrl,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui futuramente chamaremos o controller:
                // authController.register(...)
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
