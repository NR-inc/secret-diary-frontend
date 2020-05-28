import 'package:sddomain/export/domain.dart';

class LoginResponseMapper extends Mapper<dynamic, AuthTokenModel> {
  static const String _loginKey = 'login';

  @override
  AuthTokenModel map(dynamic param) =>
      AuthTokenModel.fromJson(param[_loginKey]);
}
