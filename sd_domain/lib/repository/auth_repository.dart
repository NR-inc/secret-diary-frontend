import 'package:sddomain/model/auth_token_model.dart';

abstract class AuthRepository {
  Future<AuthTokenModel> login(String email, String password);

  Future<AuthTokenModel> registration(
      String firstName, String lastName, String email, String password);
}
