abstract class ValidationRule<E> {
  final RuleType ruleType;
  final E error;

  ValidationRule(this.ruleType, this.error);

  E isValid(String value);
}

enum RuleType {
  isEmpty,
  isMatchToPattern,
  isCorrespond,
}
