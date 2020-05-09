import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sddomain/bloc/splash_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ssecretdiary/feature/widgets/common_ui.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  static const _splashScreenDelayInSec = 2;
  final _splashBloc = Injector.getInjector().get<SplashBloc>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashBloc.sessionAvailabilitySubject
        .throttleTime(Duration(seconds: _splashScreenDelayInSec),
            trailing: true)
        .listen((bool hasSession) {
      if (hasSession) {
        Navigator.pushReplacementNamed(context, AppRoutes.root);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
    _splashBloc.checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Secret Diary',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24.0)),
                  SizedBox(height: 24),
                  getLoader()
                ])));
  }
}
