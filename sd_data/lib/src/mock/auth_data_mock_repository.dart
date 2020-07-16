import 'package:sddomain/export/domain.dart';

class AuthDataMockRepository implements AuthRepository {
  @override
  Stream<AuthTokenModel> login(
    String email,
    String password,
  ) async* {
    yield AuthTokenModel('auth token');
  }

  @override
  Stream<AuthTokenModel> registration(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async* {
    yield AuthTokenModel('auth token');
  }
}
