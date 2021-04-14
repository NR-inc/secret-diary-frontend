import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/export/domain.dart';

class ChangePasswordBloc extends BaseBloc {
  final AuthInteractor _authInteractor;
  final PublishSubject<bool> _passwordChangingResult;

  ChangePasswordBloc(
      {required Logger logger,
      required AuthInteractor authInteractor,
      required PublishSubject<bool> passwordChangingResult})
      : _authInteractor = authInteractor,
        _passwordChangingResult = passwordChangingResult,
        super(logger: logger);

  void changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {

  }
}
