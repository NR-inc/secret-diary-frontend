import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/exceptions/network_exception.dart';
import 'package:sddomain/interactor/user_interactor.dart';
import 'package:sddomain/model/user_model.dart';

class UserBloc extends BaseBloc {
  final UserInteractor _userInteractor;
  final PublishSubject<UserModel> _currentUserResult;
  final PublishSubject<bool> _editProfileResult;
  final PublishSubject<bool> _passwordRequiredResult;

  Stream<UserModel> get currentUserStream => _currentUserResult.stream;

  Stream<bool> get editProfileResultStream => _editProfileResult.stream;

  Stream<bool> get passwordRequiredResult => _passwordRequiredResult.stream;

  UserBloc({
    @required Logger logger,
    @required UserInteractor userInteractor,
    @required PublishSubject<UserModel> currentUserResult,
    @required PublishSubject<bool> passwordRequiredResult,
    @required PublishSubject<bool> editProfileResult,
  })  : _userInteractor = userInteractor,
        _currentUserResult = currentUserResult,
        _passwordRequiredResult = passwordRequiredResult,
        _editProfileResult = editProfileResult,
        super(logger: logger);

  void profile() async {
    showLoading(true);
    _userInteractor.profile().then(
      (currentUser) {
        _currentUserResult.add(currentUser);
        showLoading(false);
      },
      onError: handleError,
    );
  }

  Future<bool> updateProfile({
    String firstName,
    String lastName,
    String email,
    String password,
    File avatar,
  }) async {
    showLoading(true);
    return _userInteractor
        .updateProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      validatePassword: password != null,
      avatar: avatar,
    )
        .then(
      (isProfileUpdated) {
        showLoading(false);
        _editProfileResult.add(isProfileUpdated);
        return isProfileUpdated;
      },
      onError: (e) {
        if (e is NetworkException &&
            e.description == FirestoreKeys.requiresResentLoginError) {
          _passwordRequiredResult.add(true);
          showLoading(false);
        } else {
          _editProfileResult.addError(e);
          handleError(e);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _currentUserResult.close();
  }
}
