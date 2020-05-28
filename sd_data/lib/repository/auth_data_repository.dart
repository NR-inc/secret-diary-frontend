import 'package:dio/dio.dart';
import 'package:sddata/data.dart';
import 'package:sddomain/export/domain.dart';

class AuthDataRepository extends AuthRepository {
  final Dio _dio;
  final NetworkExecutor _networkExecutor;
  final LoginResponseMapper _loginResponseMapper;
  final RegistrationResponseMapper _registrationResponseMapper;

  AuthDataRepository(
    this._dio,
    this._networkExecutor,
    this._loginResponseMapper,
    this._registrationResponseMapper,
  );

  @override
  Stream<AuthTokenModel> login(
    String email,
    String password,
  ) =>
      _networkExecutor
          .makeRequest(
              _dio,
              AuthApi.login(
                email: email,
                password: password,
              ))
          .map(_loginResponseMapper.map);

  @override
  Stream<AuthTokenModel> registration(
    String firstName,
    String lastName,
    String email,
    String password,
  ) =>
      _networkExecutor
          .makeRequest(
            _dio,
            AuthApi.registration(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password),
          )
          .map(_registrationResponseMapper.map);
}
