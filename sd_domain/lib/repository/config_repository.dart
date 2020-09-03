abstract class ConfigRepository {
  Future<void> saveUserUid(String authToken);

  Future<bool> hasSession();

  Future<void> clearUserUid();

  Future<String> getUserUid();
}
