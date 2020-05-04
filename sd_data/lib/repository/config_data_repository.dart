import 'package:sddomain/model/auth_token_model.dart';
import 'package:sddomain/repository/config_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ConfigDataRepository implements ConfigRepository {
  static const String _authTokenKey = 'authToken';
  static const _authHeaderKey = 'Authorization';

  final Dio _dio;

  ConfigDataRepository(this._dio);

  @override
  Future<bool> hasSession() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(_authTokenKey) != null;
  }

  @override
  Future<void> saveAuthToken(AuthTokenModel authToken) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    _dio.options.headers = {_authHeaderKey: 'Bearer ${authToken.getToken()}'};
    sharedPrefs.setString(_authTokenKey, authToken.toJson());
  }

  @override
  Future<void> clearAuthToken() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    _dio.options.headers = {_authHeaderKey: null};
    sharedPrefs.setString(_authTokenKey, null);
  }
}
