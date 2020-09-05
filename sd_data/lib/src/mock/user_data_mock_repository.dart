import 'package:sddomain/export/domain.dart';

class UserDataMockRepository implements UserRepository {
  @override
  Future<UserModel> getUserById(String uid) async {
    return UserModel.testUser();
  }

  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<UserModel> profile() async {
    return UserModel.testUser();
  }

  @override
  Future<void> removeAccount() async {
    return;
  }
}
