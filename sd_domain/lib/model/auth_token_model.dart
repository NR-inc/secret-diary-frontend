import 'dart:convert';

class AuthTokenModel {
  String? _token;

  AuthTokenModel(this._token);

  String toJson() => json.encode({'token': _token});

  AuthTokenModel.fromJson(dynamic data) {
    _token = data['token'];
  }

  String? getToken() => _token;

  void setToken(String value) {
    _token = value;
  }
}
