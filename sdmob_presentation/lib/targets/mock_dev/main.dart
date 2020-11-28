import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/app/app.dart';
import 'package:ssecretdiary/core/di/inject_module.dart';
import 'app_configs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InjectModule(appConfigs);
  runApp(SecretDiaryApp(appConfigs));
}
