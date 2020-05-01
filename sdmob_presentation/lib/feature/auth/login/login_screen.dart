import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sddomain/bloc/login_bloc.dart';
import 'package:sddomain/model/validation_error_model.dart';
import 'package:ssecretdiary/feature/widgets/alerts.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/model/default_response.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final LoginBloc _loginBloc = Injector.getInjector().get<LoginBloc>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc.networkErrorHandler.networkValidationError
        .listen((List<ValidationErrorModel> validationErrors) {
      showSimpleErrorDialog(
          context: context,
          title: 'Network error',
          description: validationErrors[0].message ?? 'Something went wrong',
          buttonName: 'Cancel');
    });
    _loginBloc.networkErrorHandler.networkError.listen((DioError networkError) {
      showSimpleErrorDialog(
          context: context,
          title: 'Network error',
          description: networkError.error,
          buttonName: 'Cancel');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
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
            MaterialButton(
                child: Text('Login'),
                onPressed: () async {
                  _loginBloc
                      .login(
                          emailTextController.text, passwordTextController.text)
                      .then((value) {
                    if (value == DefaultResponse.SUCCESS) {
                      Navigator.pushReplacementNamed(context, AppRoutes.root);
                    }
                  });
                }),
            MaterialButton(
              child: Text('Registration'),
              onPressed: () async {
                Navigator.pushNamed(context, AppRoutes.registration);
              },
            )
          ])),
        ),
      );
}
