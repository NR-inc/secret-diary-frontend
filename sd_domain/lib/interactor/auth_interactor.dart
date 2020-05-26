import 'dart:math';

import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/core/validation/form_validator.dart';
import 'package:sddomain/export/models.dart';
import 'package:sddomain/export/repositories.dart';
import 'package:sddomain/export/validation.dart';

class AuthInteractor {
  final ConfigRepository _configRepository;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FormValidator _loginFormValidator;

  AuthInteractor(
    this._configRepository,
    this._authRepository,
    this._userRepository,
    this._loginFormValidator,
  );

  Stream<DefaultResponse> login(String email, String password) =>
      ZipStream.zip2(
          validateForm(email, password),
          _authRepository
              .login(email, password)
              .asyncMap((AuthTokenModel authToken) async {
            await _configRepository.saveAuthToken(authToken);
            return DefaultResponse.SUCCESS;
          }), (_, response) {
        return response;
      });

  Stream<DefaultResponse> registration(
          String firstName, String lastName, String email, String password) =>
      _authRepository
          .registration(firstName, lastName, email, password)
          .asyncMap((AuthTokenModel authToken) async {
        await _configRepository.saveAuthToken(authToken);
        return DefaultResponse.SUCCESS;
      });

  Future<void> logout() async {
    await _userRepository.logout();
    await _configRepository.clearAuthToken();
  }

  Stream<void> validateForm(String email, password) =>
      _loginFormValidator.validateForm({
        InputFieldType.email: email,
        InputFieldType.password: password,
      }).asStream();

  Future<bool> hasSession() async => _configRepository.hasSession();
}
