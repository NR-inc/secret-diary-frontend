import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';

class RegistrationBloc extends BaseBloc {
  final AuthInteractor _authInteractor;

  RegistrationBloc(this._authInteractor);

  Future<void> registration(String firstName, String lastName, String email,
          String password) async =>
      _authInteractor.registration(firstName, lastName, email, password);
}
