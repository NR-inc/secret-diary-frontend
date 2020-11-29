import 'dart:io';

import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/bloc/user_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/exceptions/network_exception.dart';
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
  final _passwordRequiredLoadingProgress = ValueNotifier<bool>(false);
  var _isPasswordRequired = false;
  File _avatarFile;

  @override
  void initState() {
    _userBloc.profile();
    _userBloc.currentUserStream.listen((currentUser) {
      _firstNameController.text = currentUser.firstName;
      _lastNameController.text = currentUser.lastName;
      _emailController.text = currentUser.email;
    });
    _userBloc.loadingProgressStream.listen(
      (value) => _passwordRequiredLoadingProgress.value = value,
    );
    _userBloc.passwordRequiredResult.listen((isPasswordRequired) {
      _isPasswordRequired = isPasswordRequired;
      showPasswordRequiredDialog(
          context: context,
          passwordController: _passwordController,
          passwordErrorNotifier: _passwordErrorNotifier,
          loadingProgress: _passwordRequiredLoadingProgress,
          submitCallback: (password) {
            _updateProfileAction(
              password: password,
            );
          });
    });
    _userBloc.errorStream.listen((_) {}, onError: (ex) {
      _passwordRequiredLoadingProgress.value = false;
      if (ex is NetworkException &&
          ex.description == FirestoreKeys.wrongPasswordError) {
        _passwordErrorNotifier.value = SdStrings.fieldErrorWrongPassword;
      } else {
        handleError(ex);
      }
    });
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
                SizedBox(height: Dimens.unit2),
                FlatButton(
                  onPressed: () {
                    _resetPasswordAction();
                  },
                  child: Text(
                    SdStrings.resetMyPasswordMsg,
                    style: TextStyle(
                      fontSize: Dimens.fontSize16,
                      fontWeight: FontWeight.bold,
                      color: SdColors.secondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 24)
              ])),
              showLoader(show: snapshot.data),
            ]);
          },
        ));
  }

  void _resetPasswordAction(){

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
          if (_isPasswordRequired) {
            Navigator.pop(context);
          }
          Navigator.pop(context);
        },
      );
    }
  }
}
