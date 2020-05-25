import 'package:sddomain/core/validation/validation_rule.dart';

class EmptyRuleValidator extends ValidationRule<String> {
  EmptyRuleValidator(String error) : super(RuleType.isEmpty, error);

  @override
  String isValid(String value) {
    if (value == null || value.isEmpty) return error;
    return null;
  }
}
