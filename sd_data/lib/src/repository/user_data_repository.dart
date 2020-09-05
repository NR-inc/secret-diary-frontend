import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/core/error_handler.dart';
import 'package:sddomain/export/domain.dart';

class UserDataRepository implements UserRepository {
  final ErrorHandler _errorHandler;

  UserDataRepository(this._errorHandler);

  @override
  Future<UserModel> profile() async {
    try {
      final databaseReference = FirebaseFirestore.instance;
      final userUid = FirebaseAuth.instance.currentUser.uid;
      final user = await databaseReference
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(userUid)
          .get();
      return UserModel.fromJson(user.data(), userUid);
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<UserModel> getUserById(String uid) async {
    try {
      final databaseReference = FirebaseFirestore.instance;
      final user = await databaseReference
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(uid)
          .get();
      return UserModel.fromJson(user.data(), uid);
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    return null;
  }

  @override
  Future<void> removeAccount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final databaseReference = FirebaseFirestore.instance;

      await databaseReference
          .collection(FirestoreKeys.usersCollectionKey)
          .doc(currentUser.uid)
          .delete();
      await currentUser.delete();
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }
}
