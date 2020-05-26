export 'package:sddomain/core/validation/rules/empty_validation_rule.dart';
export 'package:sddomain/core/validation/rules/pattern_validation_rule.dart';

import 'package:flutter/foundation.dart';

abstract class ValidationRule<E> {
  final RuleType _ruleType;
  @protected
  final E error;

  ValidationRule(this._ruleType, this.error);

  E isValid(String value);
}

enum RuleType {
  isEmpty,
  isMatchToPattern,
  isCorrespond,
  isCorrectLength
}
