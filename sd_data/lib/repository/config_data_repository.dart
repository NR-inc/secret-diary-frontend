import 'package:sddomain/model/auth_token_model.dart';
import 'package:sddomain/repository/config_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigDataRepository implements ConfigRepository {
  static const String _authTokenKey = 'authToken';

  @override
  Future<AuthTokenModel> getAuthToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return AuthTokenModel.fromJson(sharedPrefs.getString(_authTokenKey));
  }

  @override
  Future<void> saveAuthToken(AuthTokenModel authToken) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(_authTokenKey, authToken.toJson());
  }

  @override
  Future<void> clearAuthToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(_authTokenKey, null);
  }
}
