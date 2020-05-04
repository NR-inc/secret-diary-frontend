import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/di/inject_module.dart';
import 'package:ssecretdiary/core/navigation/router.dart';

class SecretDiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InjectModule();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: ApplicationRouter(),
        navigatorObservers: [routeObserver],
        theme: ThemeData(primarySwatch: Colors.blue));
  }
}
