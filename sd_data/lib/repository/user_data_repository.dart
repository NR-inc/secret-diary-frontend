import 'package:dio/dio.dart';
import 'package:sddata/data.dart';
import 'package:sddomain/export/domain.dart';

class UserDataRepository implements UserRepository {
  final Dio _dio;
  final NetworkExecutor _networkExecutor;

  UserDataRepository(this._dio, this._networkExecutor);

  @override
  Future<UserModel> profile() async {
    final response = await _networkExecutor
        .makeRequest(_dio, UserApi.profile())
        .first;
    return UserModel.fromJson(response['profile']);
  }

  @override
  Future<UserModel> getUserById(int id) {
    // TODO: implement getUserById
    return null;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    return null;
  }
}
