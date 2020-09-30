import 'package:rxdart/rxdart.dart';
import 'package:sddomain/export/domain.dart';

class AuthInteractor {
  final ConfigRepository _configRepository;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FormValidator _loginFormValidator;
  final FormValidator _registrationFormValidator;
  final FormValidator _remindPasswordFormValidator;

  AuthInteractor(
    this._configRepository,
    this._authRepository,
    this._userRepository,
    this._loginFormValidator,
    this._registrationFormValidator,
    this._remindPasswordFormValidator,
  );

  // todo try to return void instead of DefaultResponse
  Stream<DefaultResponse> login(
    String email,
    String password,
  ) =>
      _loginFormValidator
          .validateForm({
            InputFieldType.email: email,
            InputFieldType.password: password,
          })
          .asStream()
          .switchMap(
            (_) => _authRepository
                .login(email, password)
                .asStream()
                .asyncMap((String userUid) async {
              await _configRepository.saveUserUid(userUid);
              return DefaultResponse.SUCCESS;
            }),
          );

  Stream<DefaultResponse> registration(
    String firstName,
    String lastName,
    String email,
    String password,
  ) =>
      _registrationFormValidator
          .validateForm({
            InputFieldType.firstName: firstName,
            InputFieldType.lastName: lastName,
            InputFieldType.email: email,
            InputFieldType.password: password,
          })
          .asStream()
          .switchMap(
            (_) => _authRepository
                .registration(firstName, lastName, email, password)
                .asStream()
                .asyncMap((String userUid) async {
              await _configRepository.saveUserUid(userUid);
              return DefaultResponse.SUCCESS;
            }),
          );

  Stream<DefaultResponse> remindPassword(
    String email,
  ) =>
      _remindPasswordFormValidator
          .validateForm({
            InputFieldType.email: email,
          })
          .asStream()
          .switchMap((_) => _authRepository.remindPassword(email));

  Future<void> logout() async {
    await _userRepository.logout();
    await _configRepository.clearUserUid();
  }

  Future<void> removeAccount() async {
    await _userRepository.removeAccount();
    await _configRepository.clearUserUid();
  }

  Future<bool> hasSession() async => _configRepository.hasSession();
}
