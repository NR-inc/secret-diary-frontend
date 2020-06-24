import 'package:dio/dio.dart';
import 'package:grpc/grpc.dart';
import 'package:sddata/data.dart';
import 'package:sddomain/export/domain.dart';
import 'package:proto_module/protos.dart';

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
  ) async* {
    final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final loginClient = LoginClient(channel);
    LoginResponse response;
    try {
      response = await loginClient.login(
        LoginRequest.create()
          ..email = email
          ..password = password,
      );
    } on Object catch (e) {
      print(e);
    }

    print('TOKEN FROM GRPC: ${response.token}');

    yield AuthTokenModel(response.token);
  }

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
