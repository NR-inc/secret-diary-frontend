import 'package:sddomain/repository/config_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigDataRepository implements ConfigRepository {
  static const String _userUidKey = 'userUid';

  ConfigDataRepository();

  @override
  Future<bool> hasSession() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(_userUidKey) != null;
  }

  @override
  Future<void> saveUserUid(String userUid) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(_userUidKey, userUid);
  }

  @override
  Future<void> clearUserUid() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(_userUidKey, null);
  }

  @override
  Future<String> getUserUid() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(_userUidKey);
  }
}
