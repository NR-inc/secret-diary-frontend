import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/bloc/registration_bloc.dart';
import 'package:sddomain/model/default_response.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';
import 'package:ssecretdiary/feature/widgets/common_ui.dart';

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
      appBar: AppBar(title: Text('Registration')),
      body: StreamBuilder(
          stream: _registrationBloc.loadingProgress,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
              Stack(children: <Widget>[
                _registrationForm(),
                showLoader(show: snapshot.hasData && snapshot.data)
              ])));

  Widget _registrationForm() => Container(
          child: Center(
        child: Column(children: <Widget>[
          TextFormField(
              controller: firstNameTextController,
              decoration: InputDecoration(hintText: 'First name')),
          TextFormField(
              controller: lastNameTextController,
              decoration: InputDecoration(hintText: 'Last name')),
          TextFormField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email')),
          TextFormField(
              controller: passwordTextController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password')),
          MaterialButton(
              child: Text('Registration'), onPressed: _registrationPressed)
        ]),
      ));

  void _registrationPressed() {
    _registrationBloc
        .registration(firstNameTextController.text, lastNameTextController.text,
            emailTextController.text, passwordTextController.text)
        .then((value) {
      if (value == DefaultResponse.SUCCESS) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.root, (route) => false);
      }
    }, onError: handleError);
  }
}
