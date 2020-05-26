import 'package:sddomain/export/domain.dart';

class LengthValidationRule extends ValidationRule<String> {
  final int max;
  final int min;
  final String minError;
  final String maxError;

  LengthValidationRule({
    this.minError = SdStrings.fieldErrorMinLength,
    this.maxError = SdStrings.fieldErrorMaxLength,
    this.max = Constants.fieldMaxLength,
    this.min = Constants.fieldMinLength,
  }) : super(RuleType.isCorrectLength, minError); // todo FIX_ME

  @override
  String isValid(String value, {dynamic args}) {
    if (value == null) {
      return minError;
    } else if (value.length < min) {
      return minError;
    } else if (value.length > max) {
      return maxError;
    } else {
      return null;
    }
  }
}
