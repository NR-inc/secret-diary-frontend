import 'package:sddomain/export/domain.dart';

class RegistrationResponseMapper extends Mapper<dynamic, AuthTokenModel> {
  static const String _registrationKey = 'register';

  @override
  AuthTokenModel map(dynamic param) =>
      AuthTokenModel.fromJson(param[_registrationKey]);
}
