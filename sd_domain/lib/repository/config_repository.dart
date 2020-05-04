import 'package:sddomain/model/auth_token_model.dart';

abstract class ConfigRepository {
  Future<void> saveAuthToken(AuthTokenModel authToken);

  Future<bool> hasSession();

  Future<void> clearAuthToken();
}
