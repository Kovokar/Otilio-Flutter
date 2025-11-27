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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_add_alt_1_outlined,
                  size: 80, color: theme.primaryColor),
              const SizedBox(height: 20),

              Text(
                "Criar Conta",
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                "Preencha os dados para continuar",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(height: 32),

              // Campo de nome
              TextField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de email
              TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de senha
              TextField(
                controller: _passCtrl,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
              ),

              const SizedBox(height: 24),

              // Botão cadastrar
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // Aqui futuramente chamaremos o controller
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  },
                  child: const Text("Cadastrar"),
                ),
              ),

              const SizedBox(height: 12),

              // Botão voltar ao login
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Já tenho uma conta"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
