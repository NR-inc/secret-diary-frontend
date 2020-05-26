import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/export/validation.dart';
import 'package:sddomain/export/models.dart';

class FormValidator {
  final Map<InputFieldType, FieldValidator> _fieldValidators;

  FormValidator(this._fieldValidators);

  Future<void> validateForm(Map<InputFieldType, String> formFields) async {
    Map<InputFieldType, String> validationErrors = {};

    for (InputFieldType key in formFields.keys) {
      String value = formFields[key];
      final invalidField = await _fieldValidators[key].validate(value);

      if (invalidField != null) {
        validationErrors.putIfAbsent(
          invalidField.inputFieldType,
          () => invalidField.error,
        );
      }
    }

    if (validationErrors.isNotEmpty) {
      throw ValidationException(
        validationErrors: validationErrors,
      );
    }
  }
}
