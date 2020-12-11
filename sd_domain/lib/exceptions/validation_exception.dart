import 'package:sddomain/model/input_field_type.dart';

class ValidationException implements Exception {
  Map<InputFieldType, String> validationErrors;
  String message;

  ValidationException(
      {this.validationErrors = const {}, this.message = 'Validation error'});

  @override
  String toString() {
    return ''
        'message: $message, \n'
        'validationErrors: $validationErrors, \n'
        '';
  }
}
