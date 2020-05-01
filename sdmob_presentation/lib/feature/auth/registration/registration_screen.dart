import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/bloc/registration_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationState();
}

class RegistrationState extends State<RegistrationScreen> {
  final RegistrationBloc _registrationBloc = Injector.getInjector().get<RegistrationBloc>();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();


  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: Container(
            child: Center(
          child: Column(children: <Widget>[
            TextFormField(decoration: InputDecoration(hintText: 'First name')),
            TextFormField(decoration: InputDecoration(hintText: 'Last name')),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email')),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password')),
            MaterialButton(
                child: Text('Registration'),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.root, (route) => false))
          ]),
        )),
      );
}
