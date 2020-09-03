import 'package:sddomain/export/domain.dart';

class ConfigDataMockRepository implements ConfigRepository {
  @override
  Future<void> clearUserUid() async {
    return;
  }

  @override
  Future<bool> hasSession() async {
    return false;
  }

  @override
  Future<void> saveUserUid(String userUid) async {
    return;
  }

  @override
  Future<String> getUserUid() async {
    return 'uid';
  }
}
