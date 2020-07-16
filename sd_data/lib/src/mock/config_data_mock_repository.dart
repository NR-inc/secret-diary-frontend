import 'package:sddomain/export/domain.dart';

class ConfigDataMockRepository implements ConfigRepository {
  @override
  Future<void> clearAuthToken() async {
    return;
  }

  @override
  Future<bool> hasSession() async {
    return false;
  }

  @override
  Future<void> saveAuthToken(AuthTokenModel authToken) async {
    return;
  }
}
