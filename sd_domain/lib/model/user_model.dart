class UserModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String avatar;

  UserModel.fromJson(dynamic data) {
    id = data['id'] ?? -1;
    firstName = data['first_name'] ?? '';
    lastName = data['last_name'] ?? '';
    email = data['email'] ?? '';
    avatar = data['avatar'] ?? '';
  }

  UserModel.testUser() {
    firstName = 'John';
    lastName = 'Cena';
    email = 'cena@gmail.com';
    avatar =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/John_Cena_July_2018.jpg/500px-John_Cena_July_2018.jpg';
  }

  UserModel.empty() {
    id = -1;
    firstName = '';
    lastName = '';
    email = '';
    avatar = '';
  }
}
