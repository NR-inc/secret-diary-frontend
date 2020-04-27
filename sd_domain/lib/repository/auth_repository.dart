abstract class AuthRepository {
  Future<void> login(String email, String password);

  Future<void> registration(
      String firstName, String lastName, String email, String password);
}
