import 'package:sddomain/core/validation/invalid_field.dart';
import 'package:sddomain/core/validation/validation_rule.dart';
import 'package:sddomain/model/input_field_type.dart';

abstract class FieldValidator {
  final List<ValidationRule> validationRules;
  final InputFieldType inputFieldType;

  FieldValidator(
    this.validationRules,
    this.inputFieldType,
  );

  Future<InvalidField> validate(String value) async {
    InvalidField invalidField;
    for (ValidationRule validationRule in validationRules) {
      String result = validationRule.isValid(value);
      if (result != null) {
        invalidField = InvalidField(inputFieldType, result);
        break;
      }
    }
    return invalidField;
  }
}
