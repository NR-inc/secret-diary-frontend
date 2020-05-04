import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';

class SplashBloc implements BaseBloc {
  final AuthInteractor _authInteractor;
  final sessionAvailabilitySubject = BehaviorSubject<bool>();

  SplashBloc(this._authInteractor);

  void checkSession() async {
    bool hasSession = await _authInteractor.hasSession();
    sessionAvailabilitySubject.add(hasSession);
  }

  @override
  void dispose() {
    sessionAvailabilitySubject.close();
  }

  @override
  void unsubscribe() {
    // TODO: implement unsubscribe
  }
}
