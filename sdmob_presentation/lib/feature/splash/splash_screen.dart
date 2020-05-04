import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sddomain/bloc/splash_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  final _splashBloc = Injector.getInjector().get<SplashBloc>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashBloc.sessionAvailabilitySubject.listen((bool hasSession) {
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
            color: Colors.blue,
            child: Center(
                child: Text(
              'Secret Diary',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24.0),
            ))));
  }
}
