import 'package:sddomain/model/auth_token_model.dart';

abstract class AuthRepository {
  Stream<AuthTokenModel> login(String email, String password);

  Stream<AuthTokenModel> registration(
      String firstName, String lastName, String email, String password);
}
