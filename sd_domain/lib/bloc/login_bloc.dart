import 'dart:async';
import 'package:async/async.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/model/default_response.dart';

class LoginBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  CancelableOperation _loginOperation;

  LoginBloc(this._authInteractor);

  Future<DefaultResponse> login(String email, String password) async {
    _loginOperation?.cancel();
    loadingProgress.add(true);
    _loginOperation =
        CancelableOperation.fromFuture(_authInteractor.login(email, password));
    _loginOperation.then((_) => loadingProgress.add(false),
        onError: (error, stackTrace) => loadingProgress.add(false),
        onCancel: () => loadingProgress.add(false));
    return await _loginOperation.value;
  }

  @override
  void unsubscribe() {
    _loginOperation?.cancel();
    super.unsubscribe();
  }
}
