import 'dart:async';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/model/default_response.dart';

class RegistrationBloc extends BaseBloc {
  final AuthInteractor _authInteractor;

  RegistrationBloc(this._authInteractor);

  Future<DefaultResponse> registration(String firstName, String lastName,
          String email, String password) async =>
      _authInteractor.registration(firstName, lastName, email, password);

  @override
  void dispose() {
    super.dispose();
  }
}
