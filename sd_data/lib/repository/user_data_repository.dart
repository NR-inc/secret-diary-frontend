import 'package:sddata/network/network_executor.dart';
import 'package:sddomain/model/user_model.dart';
import 'package:sddomain/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:sddata/network/api/user_api.dart' as userApi;

class UserDataRepository implements UserRepository {
  final Dio _dio;
  final NetworkExecutor _networkExecutor;

  UserDataRepository(this._dio, this._networkExecutor);

  @override
  Future<UserModel> profile() async {
    final response =
        await _networkExecutor.makeRequest(_dio, userApi.profile()).first;
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
