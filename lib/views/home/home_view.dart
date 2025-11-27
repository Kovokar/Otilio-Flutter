import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Principal')),
      body: Center(child: Text('Bem-vindo! (Por enquanto só texto)')),
    );
  }
}
