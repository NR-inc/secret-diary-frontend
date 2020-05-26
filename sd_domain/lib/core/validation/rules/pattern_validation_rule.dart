import 'package:flutter/foundation.dart';
import 'package:sddomain/export/domain.dart';

class PatternValidationRule extends ValidationRule<String> {
  final RegExp _regExp;

  PatternValidationRule({
    @required String error,
    String pattern = ValidationPatterns.simpleFieldPattern,
  })  : _regExp = RegExp(pattern),
        super(
          RuleType.isMatchToPattern,
          error,
        );

  @override
  String isValid(String value, {dynamic args}) =>
      _regExp.hasMatch(value) ? null : error;
}
