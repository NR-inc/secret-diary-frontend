import 'package:sddomain/model/user_model.dart';

abstract class UserRepository {
  Future<void> logout();

  Future<void> removeAccount();

  Future<UserModel> profile();

  Future<UserModel> getUserById(String uid);
}
