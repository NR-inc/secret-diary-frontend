import 'package:sddomain/export/domain.dart';

class AuthDataMockRepository implements AuthRepository {
  @override
  Future<String> login(
    String email,
    String password,
  ) async {
    print('login success');
    return 'uid';
  }

  @override
  Future<String> registration(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    print('registration success');
    return 'uid';
  }

  @override
  Stream<DefaultResponse> remindPassword(String email) async* {
    yield DefaultResponse.SUCCESS;
  }
}
