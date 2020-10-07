import 'package:sd_base/sd_base.dart';

class UserModel {
  String uid;
  String firstName;
  String lastName;
  String email;
  String avatar;

  UserModel.fromJson(dynamic data, [String uid]) {
    this.uid = uid;
    firstName = data[FirestoreKeys.firstNameFieldKey] ?? '';
    lastName = data[FirestoreKeys.lastNameFieldKey] ?? '';
    email = data[FirestoreKeys.emailFieldKey] ?? '';
    avatar = data[FirestoreKeys.avatarFieldKey] ?? '';
  }

  UserModel.testUser() {
    firstName = 'John';
    lastName = 'Cena';
    email = 'cena@gmail.com';
    avatar =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/John_Cena_July_2018.jpg/500px-John_Cena_July_2018.jpg';
  }

  UserModel.empty() {
    uid = '';
    firstName = '';
    lastName = '';
    email = '';
    avatar = '';
  }
}
