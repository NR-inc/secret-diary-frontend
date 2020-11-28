import 'dart:io';

import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sddomain/bloc/user_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends BaseState<EditProfileScreen> {
  final _userBloc = Injector.getInjector().get<UserBloc>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordErrorNotifier = ValueNotifier<String>(null);
  File _avatarFile;

  @override
  void initState() {
    _userBloc.profile();
    _userBloc.currentUserStream.listen((currentUser) {
      _firstNameController.text = currentUser.firstName;
      _lastNameController.text = currentUser.lastName;
      _emailController.text = currentUser.email;
    });
    _userBloc.passwordRequiredResult.listen((isPasswordRequired) {
      showPasswordRequiredDialog(
          context: context,
          passwordController: _passwordController,
          passwordErrorNotifier: _passwordErrorNotifier,
          submitCallback: (password) {
            Navigator.pop(context);
            _updateProfileAction(
              password: password,
            );
          });
    });
    _userBloc.errorStream.handleError(handleError);
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key(Locators.diaryScreenLocator),
        appBar: AppBar(
            title: Text('Edit profile'),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.check, color: Colors.white),
                onPressed: () => _updateProfileAction(),
              )
            ]),
        body: StreamBuilder<bool>(
          stream: _userBloc.loadingProgressStream,
          initialData: true,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Stack(children: <Widget>[
              Center(
                  child: Column(children: <Widget>[
                SizedBox(height: 24),
                Icon(Icons.account_circle, color: Colors.grey, size: 80),
                SizedBox(height: 24),
                inputField(
                  controller: _firstNameController,
                  hint: SdStrings.firstNameHint,
                ),
                SizedBox(height: 8),
                inputField(
                  controller: _lastNameController,
                  hint: SdStrings.firstNameHint,
                ),
                SizedBox(height: 8),
                inputField(
                  controller: _emailController,
                  hint: SdStrings.firstNameHint,
                ),
                SizedBox(height: 24)
              ])),
              showLoader(show: snapshot.data),
            ]);
          },
        ));
  }

  Future<void> _updateProfileAction({String password}) async {
    final result = await _userBloc.updateProfile(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: password,
      avatar: _avatarFile,
    );
    if (result == true) {
      showToast(message: SdStrings.userPostUpdateSuccessMsg);
      Future.delayed(Duration(seconds: 1)).then(
        (value) {
          Navigator.pop(context);
        },
      );
    }
  }
}
