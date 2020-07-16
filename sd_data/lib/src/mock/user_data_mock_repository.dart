import 'package:sddomain/export/domain.dart';

class UserDataMockRepository implements UserRepository {
  @override
  Future<UserModel> getUserById(int id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserModel> profile() {
    // TODO: implement profile
    throw UnimplementedError();
  }
}
