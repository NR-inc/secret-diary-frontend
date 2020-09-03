import 'package:sddomain/export/domain.dart';
import 'package:sddomain/model/user_model.dart';
import 'package:sddomain/repository/user_repository.dart';

class UserInteractor {
  final UserRepository _userRepository;
  final ConfigRepository _configRepository;

  UserInteractor(this._userRepository, this._configRepository);

  Future<UserModel> profile() async => _userRepository.profile(
        await _configRepository.getUserUid(),
      );

  Future<UserModel> getUserById(int id) async =>
      _userRepository.getUserById(id);
}
