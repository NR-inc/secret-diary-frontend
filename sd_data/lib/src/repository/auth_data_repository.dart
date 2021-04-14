import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/core/error_handler.dart';
import 'package:sddomain/export/domain.dart';

class AuthDataRepository extends AuthRepository {
  final ErrorHandler _errorHandler;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthDataRepository({
    required ErrorHandler errorHandler,
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  })   : _errorHandler = errorHandler,
        _firestore = firestore,
        _firebaseAuth = firebaseAuth;

  @override
  Future<String> login(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!.uid;
    } on Exception catch (ex) {
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
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(userCredential.user!.uid)
          .set({
        FirestoreKeys.emailFieldKey: email,
        FirestoreKeys.firstNameFieldKey: firstName,
        FirestoreKeys.lastNameFieldKey: lastName,
      });
      return userCredential.user!.uid;
    } on Exception catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<void> remindPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<void> updatePassword({
    required String newPassword,
    String? oldPassword,
  }) async {
    final currentUser = _firebaseAuth.currentUser!;
    try {
      if (oldPassword != null && oldPassword.isNotEmpty) {
        await currentUser.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: (currentUser.email)!,
            password: oldPassword,
          ),
        );
      }
      await currentUser.updatePassword(newPassword);
    } on Exception catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }
}
