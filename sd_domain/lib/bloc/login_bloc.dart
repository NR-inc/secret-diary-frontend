import 'dart:async';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/interactor/auth_interactor.dart';

class LoginBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<DefaultResponse> loginSubject;
  StreamSubscription? loginSubscription;

  LoginBloc({
    required Logger logger,
    required AuthInteractor authInteractor,
    required PublishSubject<DefaultResponse> loginSubject,
  })  : _authInteractor = authInteractor,
        this.loginSubject = loginSubject,
        super(logger: logger);

  void login(String email, String password) async {
    showLoading(true);
    loginSubscription?.cancel();
    loginSubscription = _authInteractor.login(email, password).listen(
          loginSubject.add,
          onError: (error) {
            loginSubject.addError(error);
            showLoading(false);
          },
          onDone: () => showLoading(false),
        );
  }

  @override
  void unsubscribe() {
    loginSubscription?.cancel();
    super.unsubscribe();
  }

  @override
  void dispose() {
    loginSubject.close();
    super.dispose();
  }
}
