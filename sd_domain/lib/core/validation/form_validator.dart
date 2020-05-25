import 'package:sddomain/core/validation/form_fields.dart';
import 'package:sddomain/core/validation/invalid_field.dart';

abstract class FormValidator {
  Future<List<InvalidField>> validateForm(FormFields formFields);
}
