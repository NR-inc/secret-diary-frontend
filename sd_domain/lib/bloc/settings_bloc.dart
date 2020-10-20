import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';

class SettingsBloc extends BaseBloc {
  AuthInteractor _authInteractor;

  SettingsBloc({
    @required Logger logger,
    @required AuthInteractor authInteractor,
  })  : _authInteractor = authInteractor,
        super(logger: logger);

  Future<void> logout() async => await _authInteractor.logout();

  Future<void> removeAccount() async => await _authInteractor.removeAccount();

  @override
  void dispose() {
    super.dispose();
  }
}
