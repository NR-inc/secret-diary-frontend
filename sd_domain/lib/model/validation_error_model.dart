import 'package:sddomain/model/input_field_type.dart';

class ValidationErrorModel {
  InputFieldType inputFieldType;
  String message;

  ValidationErrorModel.fromJson(Map<String, dynamic> data) {
    message = data['message'];
  }
}
