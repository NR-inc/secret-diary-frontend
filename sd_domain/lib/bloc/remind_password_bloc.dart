import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/export/interactor.dart';
import 'package:sddomain/model/default_response.dart';

class RemindPasswordBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<DefaultResponse> remindPasswordResult;

  RemindPasswordBloc(
    this._authInteractor,
    this.remindPasswordResult,
  );

  void remindPassword(String email) async {
    showLoading(true);
    _authInteractor.remindPassword(email).then(
      remindPasswordResult.add,
      onError: (ex) {
        if (ex is ValidationException) {
          remindPasswordResult.addError(ex);
          showLoading(false);
        } else {
          handleError(ex);
        }
      },
    );
  }

  @override
  void dispose() {
    remindPasswordResult.close();
    super.dispose();
  }
}
