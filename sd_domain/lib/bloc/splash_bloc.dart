import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/auth_interactor.dart';

class SplashBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final sessionAvailabilitySubject = BehaviorSubject<bool>();

  SplashBloc(this._authInteractor);

  void checkSession() async {
    bool hasSession = await _authInteractor.hasSession();
    sessionAvailabilitySubject.add(hasSession);
  }

  @override
  void dispose() {
    super.dispose();
    sessionAvailabilitySubject.close();
  }
}
