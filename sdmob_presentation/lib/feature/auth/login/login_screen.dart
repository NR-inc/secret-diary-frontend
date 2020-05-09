import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sddomain/bloc/login_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/model/default_response.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';
import 'package:ssecretdiary/feature/widgets/common_ui.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends BaseState<LoginScreen> {
  final LoginBloc _loginBloc = Injector.getInjector().get<LoginBloc>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _loginBloc.unsubscribe();
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: StreamBuilder(
          stream: _loginBloc.loadingProgress.stream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Stack(children: <Widget>[
              loginForm(),
              showLoader(show: snapshot.hasData && snapshot.data)
            ]);
          },
        ),
      );

  Widget loginForm() => Container(
        child: Center(
            child: Column(children: <Widget>[
          TextFormField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email')),
          TextFormField(
              controller: passwordTextController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password')),
          MaterialButton(child: Text('Login'), onPressed: _loginPressed),
          MaterialButton(
            child: Text('Registration'),
            onPressed: _registrationPressed,
          )
        ])),
      );

  void _loginPressed() {
    _loginBloc
        .login(emailTextController.text, passwordTextController.text)
        .then((value) {
      if (value == DefaultResponse.SUCCESS) {
        Navigator.pushReplacementNamed(context, AppRoutes.root);
      }
    }, onError: handleError);
  }

  void _registrationPressed() {
    Navigator.pushNamed(context, AppRoutes.registration);
  }
}
