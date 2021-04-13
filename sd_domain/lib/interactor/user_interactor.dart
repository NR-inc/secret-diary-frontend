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
    required String firstName,
    required String lastName,
    required String email,
    String? password,
    required bool validatePassword,
    File? avatar,
    required bool cleanAvatar,
  }) async {
    final fieldsMap = <InputFieldType, String?>{
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
      cleanAvatar: cleanAvatar,
    );
  }

  Future<UserModel> getUserById(String uid) async =>
      _userRepository.getUserById(uid);
}
