import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/model/input_field_type.dart';
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
  void initState() {
    _loginBloc.loginSubject.listen((_) {
      Navigator.pushReplacementNamed(context, AppRoutes.root);
    }, onError: handleError);
    super.initState();
  }

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
            stream: _loginBloc.loadingProgress,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return Stack(children: <Widget>[
                StreamBuilder(
                    stream: _loginBloc.loginSubject,
                    builder: (BuildContext context,
                        AsyncSnapshot<DefaultResponse> snapshot) {
                      Map<InputFieldType, String> validationErrors = snapshot
                                  .hasError &&
                              snapshot.error?.runtimeType == ValidationException
                          ? (snapshot.error as ValidationException)
                              .validationErrors
                          : {};
                      return loginForm(validationErrors: validationErrors);
                    }),
                showLoader(show: snapshot.hasData && snapshot.data)
              ]);
            }),
      );

  Widget loginForm({Map<InputFieldType, String> validationErrors}) => Container(
        child: Center(
            child: Column(children: <Widget>[
          TextFormField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: validationErrors[InputFieldType.email])),
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

  void _loginPressed() =>
      _loginBloc.login(emailTextController.text, passwordTextController.text);

  void _registrationPressed() =>
      Navigator.pushNamed(context, AppRoutes.registration);
}
