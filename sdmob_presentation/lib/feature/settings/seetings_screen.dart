import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sddomain/bloc/settings_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  final SettingsBloc _settingsBloc = Injector.getInjector().get<SettingsBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Settings'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () async {
                    await _settingsBloc.logout();
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                  })
            ]),
        body: Center(child: Center(child: Text('Settings screen'))));
  }
}
