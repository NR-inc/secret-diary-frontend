import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/navigation/router.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.registration),
            )
          ])),
        ),
      );
}
