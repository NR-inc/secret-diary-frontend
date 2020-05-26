import 'package:flutter/foundation.dart';
import 'package:sddomain/export/validation.dart';

class EmptyValidationRule extends ValidationRule<String> {
  EmptyValidationRule({@required String error})
      : super(RuleType.isEmpty, error);

  @override
  String isValid(String value, {dynamic args}) {
    if (value == null || value.isEmpty) return error;
    return null;
  }
}
