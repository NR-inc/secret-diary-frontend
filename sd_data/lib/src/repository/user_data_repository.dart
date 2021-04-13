import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/core/error_handler.dart';
import 'package:sddomain/export/domain.dart';

class UserDataRepository implements UserRepository {
  final ErrorHandler _errorHandler;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  UserDataRepository({
    required ErrorHandler errorHandler,
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  })  : _errorHandler = errorHandler,
        _firestore = firestore,
        _firebaseAuth = firebaseAuth;

  @override
  Future<UserModel> profile() async {
    try {
      final userUid = _firebaseAuth.currentUser!.uid;
      final user = await _firestore
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(userUid)
          .get();
      return UserModel.fromJson(user.data(), userUid);
    } on Exception catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<UserModel> getUserById(String uid) async {
    try {
      final user = await _firestore
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(uid)
          .get();
      return UserModel.fromJson(user.data(), uid);
    } on Exception catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    return null;
  }

  @override
  Future<void> removeAccount() async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      await _firestore
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(currentUser!.uid)
          .delete();
      await currentUser.delete();
    } on Exception catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    File? avatar,
  }) async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      final userDataMap = <String, String>{};
      if (firstName != null) {
        userDataMap.putIfAbsent(
          FirestoreKeys.firstNameFieldKey,
          () => firstName,
        );
      }
      if (lastName != null) {
        userDataMap.putIfAbsent(
          FirestoreKeys.lastNameFieldKey,
          () => lastName,
        );
      }

      if (email != null) {
        if (password != null) {
          await currentUser!.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: (currentUser.email)!,
              password: password,
            ),
          );
        }
        await currentUser!.updateEmail(email);
        userDataMap.putIfAbsent(
          FirestoreKeys.emailFieldKey,
          () => email,
        );
      }
      if (avatar != null) {
        //todo
      }

      await _firestore
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(currentUser!.uid)
          .update(userDataMap);
      return true;
    } on Exception catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }
}
