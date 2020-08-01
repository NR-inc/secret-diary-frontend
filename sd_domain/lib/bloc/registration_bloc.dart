import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/model/default_response.dart';

class RegistrationBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<DefaultResponse> registrationResult;
  StreamSubscription registrationSubscription;

  RegistrationBloc(this._authInteractor, this.registrationResult);

  void registration(String firstName, String lastName, String email, String password) async {
    loadingProgress.add(true);
    registrationSubscription?.cancel();
    registrationSubscription =
        _authInteractor.registration(firstName, lastName, email, password).listen(registrationResult.add,
            onError: (error) {
              registrationResult.addError(error);
              loadingProgress.add(false);
            },
            onDone: () => loadingProgress.add(false));
  }

  @override
  void unsubscribe() {
    registrationSubscription?.cancel();
    super.unsubscribe();
  }

  @override
  void dispose() {
    registrationResult.close();
    super.dispose();
  }
}
