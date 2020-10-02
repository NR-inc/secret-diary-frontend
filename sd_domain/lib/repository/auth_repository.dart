abstract class AuthRepository {
  Future<String> login(
    String email,
    String password,
  );

  Future<String> registration(
    String firstName,
    String lastName,
    String email,
    String password,
  );

  Future<void> remindPassword(String email);
}
