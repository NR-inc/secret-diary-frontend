import 'package:dio/dio.dart';
import 'package:sddata/network/network_executor.dart';
import 'package:sddomain/repository/auth_repository.dart';
import 'package:sddomain/model/auth_token_model.dart';
import 'package:sddata/network/auth.dart' as auth_graphql;

class AuthDataRepository extends AuthRepository {
  Dio _dio;
  NetworkExecutor _networkExecutor;

  AuthDataRepository(this._dio, this._networkExecutor);

  @override
  Future<AuthTokenModel> login(String email, String password) async {
    final query = auth_graphql.login(email: email, password: password);
    final response = await _networkExecutor.makeRequest(_dio, query);
    return AuthTokenModel.fromJson(response);
  }

  @override
  Future<AuthTokenModel> registration(
      String firstName, String lastName, String email, String password) async {
    final query = auth_graphql.registration(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
    final response = await _networkExecutor.makeRequest(_dio, query);
    return AuthTokenModel.fromJson(response);
  }

  @override
  Future<void> logout() {
    print('logout has not implemented yet');
  }
}
