import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/model/input_field_type.dart';
import 'package:common_ui/common_ui.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/bloc/registration_bloc.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationState();
}

class RegistrationState extends BaseState<RegistrationScreen> {
  final RegistrationBloc _registrationBloc =
      Injector.getInjector().get<RegistrationBloc>();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void initState() {
    _registrationBloc.registrationSubject.listen(
      (_) => Navigator.pushReplacementNamed(context, AppRoutes.root),
      onError: handleError,
    );
    super.initState();
  }

  @override
  void dispose() {
    _registrationBloc.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _registrationBloc.unsubscribe();
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: getAppBar(
        key: Locators.registrationScreenLocator,
        title: SdStrings.registration,
      ),
      body: StreamBuilder(
          stream: _registrationBloc.loadingProgress,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
              Stack(children: <Widget>[
                _registrationForm(),
                showLoader(show: snapshot.hasData && snapshot.data)
              ])));

  Widget _registrationForm() => StreamBuilder(
        stream: _registrationBloc.registrationSubject,
        builder: (context, snapshot) {
          Map<InputFieldType, String> validationErrors = snapshot.hasError &&
                  snapshot.error?.runtimeType == ValidationException
              ? (snapshot.error as ValidationException).validationErrors
              : {};
          return Container(
              padding: EdgeInsets.all(Dimens.unit2),
              child: Center(
                child: Column(children: <Widget>[
                  inputField(
                    inputFieldKey: Key(Locators.firstNameFieldLocator),
                    errorFieldKey: Key(Locators.firstNameErrorLocator),
                    controller: firstNameTextController,
                    hint: SdStrings.firstNameHint,
                    error: validationErrors[InputFieldType.firstName],
                  ),
                  inputField(
                    inputFieldKey: Key(Locators.lastNameFieldLocator),
                    errorFieldKey: Key(Locators.lastNameErrorLocator),
                    controller: lastNameTextController,
                    hint: SdStrings.lastNameHint,
                    error: validationErrors[InputFieldType.lastName],
                  ),
                  inputField(
                    inputFieldKey: Key(Locators.emailFieldLocator),
                    errorFieldKey: Key(Locators.emailErrorLocator),
                    controller: emailTextController,
                    hint: SdStrings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    error: validationErrors[InputFieldType.email],
                  ),
                  inputField(
                    inputFieldKey: Key(Locators.passwordFieldLocator),
                    errorFieldKey: Key(Locators.passwordErrorLocator),
                    controller: passwordTextController,
                    hint: SdStrings.passwordHint,
                    obscureText: true,
                    error: validationErrors[InputFieldType.password],
                  ),
                  simpleButton(
                    key: Locators.registrationButtonLocator,
                    text: SdStrings.registration,
                    onPressed: _registrationPressed,
                  )
                ]),
              ));
        },
      );

  void _registrationPressed() {
    _registrationBloc.registration(
        firstNameTextController.text,
        lastNameTextController.text,
        emailTextController.text,
        passwordTextController.text);
  }
}
