import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sddomain/model/validation_error_model.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/bloc/registration_bloc.dart';
import 'package:sddomain/model/default_response.dart';
import 'package:ssecretdiary/feature/widgets/alerts.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationState();
}

class RegistrationState extends State<RegistrationScreen> with RouteAware {
  final RegistrationBloc _registrationBloc =
      Injector.getInjector().get<RegistrationBloc>();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _registrationBloc.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _registrationBloc.unsubscribe();
  }

  @override
  void didPush() {
    _handleErrors();
  }

  @override
  void didPopNext() {
    _handleErrors();
  }

  void _handleErrors() {
    _registrationBloc.handleNetworkError((DioError networkError) {
      showSimpleErrorDialog(
          context: context,
          title: 'Network error',
          description: networkError.error,
          buttonName: 'Cancel');
    });
    _registrationBloc
        .handleValidationError((List<ValidationErrorModel> validationErrors) {
      showSimpleErrorDialog(
          context: context,
          title: 'Network error',
          description: validationErrors[0].message ?? 'Something went wrong',
          buttonName: 'Cancel');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: Container(
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
                child: Text('Registration'),
                onPressed: () {
                  _registrationBloc
                      .registration(
                          firstNameTextController.text,
                          lastNameTextController.text,
                          emailTextController.text,
                          passwordTextController.text)
                      .then((DefaultResponse value) {
                    if (value == DefaultResponse.SUCCESS) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.root, (route) => false);
                    }
                  });
                })
          ]),
        )),
      );
}
