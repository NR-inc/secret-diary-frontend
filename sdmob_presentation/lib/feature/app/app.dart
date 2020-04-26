import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/navigation/router.dart';

class SecretDiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: ApplicationRouter(),
        theme: ThemeData(primarySwatch: Colors.orange));
  }
}
