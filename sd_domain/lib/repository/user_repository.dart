import 'dart:io';

import 'package:sddomain/model/user_model.dart';

abstract class UserRepository {
  Future<void> logout();

  Future<void> removeAccount();

  Future<UserModel> profile();

  Future<UserModel> getUserById(String uid);

  Future<bool> updateProfile({
    String firstName,
    String lastName,
    String email,
    String? password,
    File? avatar,
    required bool cleanAvatar,
  });
}
