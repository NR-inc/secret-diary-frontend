import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  static const _splashScreenDurationSec = 3;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: _splashScreenDurationSec),
        () => Navigator.pushReplacementNamed(context, AppRoutes.login));
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
