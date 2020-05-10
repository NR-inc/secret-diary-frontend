import 'package:dio/dio.dart';
import 'package:sddata/network/network_executor.dart';
import 'package:sddomain/repository/auth_repository.dart';
import 'package:sddomain/model/auth_token_model.dart';
import 'package:sddata/network/api/auth_api.dart' as authApi;

class AuthDataRepository extends AuthRepository {
  final Dio _dio;
  final NetworkExecutor _networkExecutor;

  AuthDataRepository(this._dio, this._networkExecutor);

  @override
  Stream<AuthTokenModel> login(String email, String password) {
    final query = authApi.login(email: email, password: password);
    return _networkExecutor.makeRequest(_dio, query)
        .map((response) => AuthTokenModel.fromJson(response['login']));
  }

  @override
  Future<AuthTokenModel> registration(
      String firstName, String lastName, String email, String password) async {
    final query = authApi.registration(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
    final response = await _networkExecutor.makeRequest(_dio, query).first;
    return AuthTokenModel.fromJson(response['register']);
  }
}
