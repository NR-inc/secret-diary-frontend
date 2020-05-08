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
    _registrationOperation = CancelableOperation.fromFuture(
        _authInteractor.registration(firstName, lastName, email, password));
    return _registrationOperation.value;
  }

  @override
  void unsubscribe() {
    _registrationOperation?.cancel();
    super.unsubscribe();
  }
}
