import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/repository/auth_repository.dart';

class LoginBloc implements BaseBloc {
  AuthRepository _authRepository;

  LoginBloc(this._authRepository);

  Future<void> login(String email, String password) async {
    return await _authRepository.login(email, password);
  }
}
