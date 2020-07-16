import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/di/inject_module.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sd_base/sd_base.dart';

class SecretDiaryApp extends StatefulWidget {
  final AppConfigs appConfigs;

  SecretDiaryApp(this.appConfigs);

  @override
  State<StatefulWidget> createState() => _SecretDiaryState();
}

class _SecretDiaryState extends State<SecretDiaryApp> {
  @override
  void initState() {
    InjectModule(widget.appConfigs);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: ApplicationRouter(),
      navigatorObservers: [routeObserver],
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
