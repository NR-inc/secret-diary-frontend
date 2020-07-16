import 'package:sddomain/export/domain.dart';

class AuthDataMockRepository implements AuthRepository {

  @override
  Stream<AuthTokenModel> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Stream<AuthTokenModel> registration(String firstName, String lastName, String email, String password) {
    // TODO: implement registration
    throw UnimplementedError();
  }

}