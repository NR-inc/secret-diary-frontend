import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Settings'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (route) => false),
              )
            ]),
        body: Center(child: Center(child: Text('Settings screen'))));
  }
}
