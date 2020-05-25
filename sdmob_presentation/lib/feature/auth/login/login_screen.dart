import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/model/input_field_type.dart';
import 'package:ssecretdiary/core/common_ui/common_ui.dart';
import 'package:ssecretdiary/core/constants/dimens.dart';
import 'package:ssecretdiary/core/constants/locators.dart';
import 'package:ssecretdiary/core/constants/sd_strings.dart';
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
    _loginBloc.loginSubject.listen(
      (_) => Navigator.pushReplacementNamed(context, AppRoutes.root),
      onError: handleError,
    );
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
    emailTextController.clear();
    passwordTextController.clear();
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
                loginForm(),
                showLoader(show: snapshot.hasData && snapshot.data)
              ]);
            }),
      );

  Widget loginForm() => StreamBuilder(
        stream: _loginBloc.loginSubject,
        builder:
            (BuildContext context, AsyncSnapshot<DefaultResponse> snapshot) {
          Map<InputFieldType, String> validationErrors = snapshot.hasError &&
                  snapshot.error?.runtimeType == ValidationException
              ? (snapshot.error as ValidationException).validationErrors
              : {};
          return Container(
            padding: EdgeInsets.all(Dimens.unit2),
            child: Center(
              child: Column(
                children: <Widget>[
                  inputField(
                    inputFieldKey: Key(Locators.emailFieldLocator),
                    errorFieldKey: Key(Locators.emailErrorLocator),
                    controller: emailTextController,
                    hint: SdStrings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    error: validationErrors[InputFieldType.email],
                  ),
                  SizedBox(height: Dimens.unit2),
                  inputField(
                    inputFieldKey: Key(Locators.passwordFieldLocator),
                    errorFieldKey: Key(Locators.passwordErrorLocator),
                    controller: passwordTextController,
                    hint: SdStrings.passwordHint,
                    obscureText: true,
                    error: validationErrors[InputFieldType.password],
                  ),
                  MaterialButton(
                      child: Text('Login'), onPressed: _loginPressed),
                  MaterialButton(
                    child: Text('Registration'),
                    onPressed: _registrationPressed,
                  ),
                ],
              ),
            ),
          );
        },
      );

  void _loginPressed() =>
      _loginBloc.login(emailTextController.text, passwordTextController.text);

  void _registrationPressed() =>
      Navigator.pushNamed(context, AppRoutes.registration);
}
