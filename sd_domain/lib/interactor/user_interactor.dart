import 'dart:io';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/model/user_model.dart';
import 'package:sddomain/repository/user_repository.dart';

class UserInteractor {
  final UserRepository _userRepository;

  UserInteractor(this._userRepository);

  Future<UserModel> profile() async => _userRepository.profile();

  Future<bool> updateProfile({
    String firstName,
    String lastName,
    String email,
    String password,
    File avatar,
  }) =>
      _userRepository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        avatar: avatar,
      );

  Future<UserModel> getUserById(String uid) async =>
      _userRepository.getUserById(uid);
}
