import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/interactor/auth_interactor.dart';

class LoginBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<DefaultResponse> loginSubject;
  StreamSubscription loginSubscription;

  LoginBloc(this._authInteractor, this.loginSubject);

  void login(String email, String password) async {
    loadingProgress.add(true);
    loginSubscription?.cancel();
    loginSubscription =
        _authInteractor.login(email, password).listen(loginSubject.add,
            onError: (error) {
              loginSubject.addError(error);
              loadingProgress.add(false);
            },
            onDone: () => loadingProgress.add(false));
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
