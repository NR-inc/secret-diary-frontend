import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/export/interactor.dart';
import 'package:sddomain/model/default_response.dart';

class RemindPasswordBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<DefaultResponse> remindPasswordSubject;
  StreamSubscription remindPasswordSubscription;

  RemindPasswordBloc(this._authInteractor, this.remindPasswordSubject);

  void remindPassword(String email) async {
    loadingProgress.add(true);
    remindPasswordSubscription?.cancel();
    remindPasswordSubscription =
        _authInteractor.remindPassword(email).listen(remindPasswordSubject.add,
            onError: (error) {
              remindPasswordSubject.addError(error);
              loadingProgress.add(false);
            },
            onDone: () => loadingProgress.add(false));
  }

  @override
  void unsubscribe() {
    remindPasswordSubscription?.cancel();
    super.unsubscribe();
  }

  @override
  void dispose() {
    remindPasswordSubject.close();
    super.dispose();
  }
}
