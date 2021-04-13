import 'dart:async';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';
import 'package:sddomain/model/default_response.dart';

class RegistrationBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<DefaultResponse> registrationResult;
  StreamSubscription? registrationSubscription;

  RegistrationBloc({
    required Logger logger,
    required AuthInteractor authInteractor,
    required PublishSubject<DefaultResponse> registrationResult,
  })  : _authInteractor = authInteractor,
        this.registrationResult = registrationResult,
        super(logger: logger);

  void registration(
      String firstName, String lastName, String email, String password) async {
    showLoading(true);
    registrationSubscription?.cancel();
    registrationSubscription = _authInteractor
        .registration(firstName, lastName, email, password)
        .listen(registrationResult.add,
            onError: (error) {
              registrationResult.addError(error);
              showLoading(false);
            },
            onDone: () => showLoading(false));
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
