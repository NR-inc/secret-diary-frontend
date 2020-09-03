import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sd_data/sd_data.dart';
import 'package:sddomain/core/error_handler.dart';
import 'package:sddomain/export/domain.dart';

class UserDataRepository implements UserRepository {
  final ErrorHandler _errorHandler;

  UserDataRepository(this._errorHandler);

  @override
  Future<UserModel> profile(String userUid) async {
    DatabaseReference usersDbRef =
    FirebaseDatabase.instance.reference().child("Users");
    final user = await usersDbRef.child(userUid).once();
    return UserModel.fromJson(user);
  }

  @override
  Future<UserModel> getUserById(int id) {
    // TODO: implement getUserById
    return null;
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    return null;
  }
}
