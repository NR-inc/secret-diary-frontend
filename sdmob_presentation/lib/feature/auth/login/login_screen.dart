import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/di/abstract_module.dart';
import 'package:ssecretdiary/core/di/auth_module.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:ssecretdiary/feature/auth/login/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final LoginBloc _loginBloc = AuthModule().get<LoginBloc>();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          child: Center(
              child: Column(children: <Widget>[
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email')),
                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password')),
                MaterialButton(
                  child: Text('Login into the app'),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, AppRoutes.root),
                ),
                MaterialButton(
                  child: Text('Registration'),
                  onPressed: () {
                    _loginBloc.pr();
                    Navigator.pushNamed(context, AppRoutes.registration);
                  },
                )
              ])),
        ),
      );
}
