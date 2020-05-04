import 'dart:async';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/model/default_response.dart';

class LoginBloc implements BaseBloc {
  AuthInteractor _authInteractor;

  LoginBloc(this._authInteractor);

  Future<DefaultResponse> login(String email, String password) async {
    return await _authInteractor.login(email, password);
  }

  @override
  void dispose() {}

  @override
  void unsubscribe() {}
}
