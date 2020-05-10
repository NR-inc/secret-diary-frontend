import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/model/default_response.dart';

class RegistrationBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<DefaultResponse> registrationSubject;
  StreamSubscription registrationSubscription;

  RegistrationBloc(this._authInteractor, this.registrationSubject);

  void registration(String firstName, String lastName, String email, String password) async {
    loadingProgress.add(true);
    registrationSubscription?.cancel();
    registrationSubscription =
        _authInteractor.registration(firstName, lastName, email, password).listen(registrationSubject.add,
            onError: (error) {
              registrationSubject.addError(error);
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
    registrationSubject.close();
    super.dispose();
  }
}
