import 'package:sddomain/model/user_model.dart';
import 'package:sddomain/repository/user_repository.dart';

class UserInteractor {
  final UserRepository _userRepository;

  UserInteractor(this._userRepository);

  Future<UserModel> profile() async => _userRepository.profile();

  Future<UserModel> getUserById(int id) async =>
      _userRepository.getUserById(id);
}
