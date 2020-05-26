import 'package:sddomain/export/validation.dart';
import 'package:sddomain/export/models.dart';

class FieldValidator {
  final List<ValidationRule> _validationRules;
  final InputFieldType _inputFieldType;

  FieldValidator(
    this._inputFieldType,
    this._validationRules,
  );

  Future<InvalidField> validate(String value) async {
    InvalidField invalidField;
    for (ValidationRule validationRule in _validationRules) {
      String result = validationRule.isValid(value);
      if (result != null) {
        invalidField = InvalidField(_inputFieldType, result);
        break;
      }
    }
    return invalidField;
  }
}
