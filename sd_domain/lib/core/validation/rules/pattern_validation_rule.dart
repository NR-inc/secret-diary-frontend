import 'package:common_ui/common_ui.dart';
import 'package:sddomain/export/domain.dart';

class PatternValidationRule extends ValidationRule<String> {
  final RegExp _regExp;

  PatternValidationRule({
    required String error,
    String pattern = ValidationPatterns.simpleFieldPattern,
  })  : _regExp = RegExp(pattern),
        super(
          RuleType.isMatchToPattern,
          error,
        );

  @override
  String? isValid(String? value, {dynamic args}) =>
      _regExp.hasMatch(value ?? SdStrings.empty) ? null : error;
}
