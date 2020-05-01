import 'dart:convert';

class AuthTokenModel {
  String _token;

  AuthTokenModel(this._token);

  String toJson() => json.encode({'token': _token});

  AuthTokenModel.fromJson(dynamic data) {
    Map valueMap = json.decode(data);
    _token = valueMap['token'];
  }

  String getToken() => _token;

  void setToken(String value) {
    _token = value;
  }
}
