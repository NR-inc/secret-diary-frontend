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
  Stream<AuthTokenModel> login(String email, String password) =>
      _networkExecutor
          .makeRequest(_dio, authApi.login(email: email, password: password))
          .map((response) => AuthTokenModel.fromJson(response['login']));

  @override
  Stream<AuthTokenModel> registration(
          String firstName, String lastName, String email, String password) =>
      _networkExecutor
          .makeRequest(
              _dio,
              authApi.registration(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  password: password))
          .map((response) => AuthTokenModel.fromJson(response['register']));
}
