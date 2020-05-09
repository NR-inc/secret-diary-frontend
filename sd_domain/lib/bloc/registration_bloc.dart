import 'dart:async';
import 'package:async/async.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/model/default_response.dart';

class RegistrationBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  CancelableOperation _registrationOperation;

  RegistrationBloc(this._authInteractor);

  Future<DefaultResponse> registration(
      String firstName, String lastName, String email, String password) async {
    _registrationOperation?.cancel();
    loadingProgress.add(true);
    _registrationOperation = CancelableOperation.fromFuture(
        _authInteractor.registration(firstName, lastName, email, password));
    _registrationOperation.then((_) => loadingProgress.add(false),
        onError: (error, stackTrace) => loadingProgress.add(false),
        onCancel: () => loadingProgress.add(false));
    return await _registrationOperation.value;
  }

  @override
  void unsubscribe() {
    _registrationOperation?.cancel();
    super.unsubscribe();
  }
}
