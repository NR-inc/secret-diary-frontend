import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';

class SettingsBloc extends BaseBloc {
  AuthInteractor _authInteractor;

  SettingsBloc(this._authInteractor);

  Future<void> logout() async => await _authInteractor.logout();
}
