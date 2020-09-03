import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sddomain/core/error_handler.dart';
import 'package:sddomain/export/domain.dart';

class AuthDataRepository extends AuthRepository {
  final ErrorHandler _errorHandler;

  AuthDataRepository(this._errorHandler);

  @override
  Future<String> login(
    String email,
    String password,
  ) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<String> registration(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      DatabaseReference usersDbRef =
          FirebaseDatabase.instance.reference().child("Users");
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      usersDbRef.child(userCredential.user.uid).set({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      });

      return userCredential.user.uid;
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }
}
