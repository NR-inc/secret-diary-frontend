import 'package:flutter/cupertino.dart';
import 'package:sddomain/export/validation.dart';

class LengthValidationRule extends ValidationRule<String> {
  final int max;
  final int min;

  LengthValidationRule({@required String error, this.max = 50, this.min = 3})
      : super(RuleType.isCorrectLength, error);

  @override
  String isValid(String value) =>
      value != null && (value.length <= max && value.length >= min)
          ? null
          : error;
}
