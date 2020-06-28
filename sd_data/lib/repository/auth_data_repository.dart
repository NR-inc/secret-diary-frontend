import 'package:sddomain/export/domain.dart';
import 'package:proto_module/protos.dart';

class AuthDataRepository extends AuthRepository {
  final AuthClient _authClient;

  AuthDataRepository(this._authClient);

  @override
  Stream<AuthTokenModel> login(
    String email,
    String password,
  ) async* {
    LoginResponse response;
    try {
      response = await _authClient.login(
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
  ) async* {

    RegistrationResponse response;
    try {
      response = await _authClient.registration(
        RegistrationRequest.create()
          ..firstName = firstName
          ..lastName = lastName
          ..email = email
          ..password = password,
      );
    } on Object catch (e) {
      print(e);
    }

    print('TOKEN FROM GRPC: ${response.token}');

    yield AuthTokenModel(response.token);

  }
}
