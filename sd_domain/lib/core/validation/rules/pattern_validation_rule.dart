import 'package:sddomain/core/validation/validation_rule.dart';

class PatternValidationRule extends ValidationRule<String> {
  final RegExp _regExp;

  PatternValidationRule({
    String error,
    String pattern,
  })  : _regExp = RegExp(pattern),
        super(
          RuleType.isMatchToPattern,
          error,
        );

  @override
  String isValid(String value, {dynamic args}) =>
      _regExp.hasMatch(value) ? null : error;
}
