import 'dart:io';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/model/user_model.dart';
import 'package:sddomain/repository/user_repository.dart';

class UserInteractor {
  final UserRepository _userRepository;
  final FormValidator _editProfileFormValidator;

  UserInteractor(
    this._userRepository,
    this._editProfileFormValidator,
  );

  Future<UserModel> profile() async => _userRepository.profile();

  Future<bool> updateProfile({
    String firstName,
    String lastName,
    String email,
    String password,
    bool validatePassword,
    File avatar,
  }) async {
    final fieldsMap = {
      InputFieldType.firstName: firstName,
      InputFieldType.lastName: lastName,
      InputFieldType.email: email,
    };
    if (validatePassword) {
      fieldsMap.putIfAbsent(InputFieldType.password, () => password);
    }
    await _editProfileFormValidator.validateForm(fieldsMap);
    return _userRepository.updateProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      avatar: avatar,
    );
  }

  Future<UserModel> getUserById(String uid) async =>
      _userRepository.getUserById(uid);
}
