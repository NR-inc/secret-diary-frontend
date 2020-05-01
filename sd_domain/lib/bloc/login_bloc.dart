import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/network/network_error_handler.dart';
import 'package:sddomain/model/default_response.dart';

class LoginBloc implements BaseBloc {
  AuthInteractor _authInteractor;
  NetworkErrorHandler networkErrorHandler;

  LoginBloc(this._authInteractor, this.networkErrorHandler);

  Future<DefaultResponse> login(String email, String password) async {
    return await _authInteractor.login(email, password);
  }
}
