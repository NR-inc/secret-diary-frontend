import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/model/auth_token_model.dart';
import 'package:sddomain/model/default_response.dart';
import 'package:sddomain/model/input_field_type.dart';
import 'package:sddomain/repository/auth_repository.dart';
import 'package:sddomain/repository/config_repository.dart';
import 'package:sddomain/repository/user_repository.dart';

class AuthInteractor {
  ConfigRepository _configRepository;
  AuthRepository _authRepository;
  UserRepository _userRepository;

  AuthInteractor(
      this._configRepository, this._authRepository, this._userRepository);

  Stream<DefaultResponse> login(String email, String password) {
    /*return Stream.error(ValidationException(
        validationErrors: {InputFieldType.email: 'Invalid email'}));*/
    return _authRepository
        .login(email, password)
        .asyncMap((AuthTokenModel authToken) async {
      await _configRepository.saveAuthToken(authToken);
      return DefaultResponse.SUCCESS;
    });
  }

  Future<DefaultResponse> registration(
      String firstName, String lastName, String email, String password) async {
    final authToken = await _authRepository.registration(
        firstName, lastName, email, password);
    await _configRepository.saveAuthToken(authToken);
    return DefaultResponse.SUCCESS;
  }

  Future<void> logout() async {
    await _userRepository.logout();
    await _configRepository.clearAuthToken();
  }

  Future<bool> hasSession() async => _configRepository.hasSession();
}
