import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
/* Removed missing import 'firebase_options.dart'. If you used FlutterFire CLI, re-run it to generate firebase_options.dart. */
import 'controllers/auth_controller.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp();

  // Inicializar Hive
  await Hive.initFlutter();
  await Hive.openBox('users');
  await Hive.openBox('locations');
  await Hive.openBox('auth');

  // Inicializar AuthController com persistência
  await AuthController.instance.init();

  runApp(App());
}
