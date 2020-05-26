import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sdbase/di/abstract_module.dart';
import 'package:sddomain/core/validation/rules/length_validation_rule.dart';
import 'package:sddomain/export/domain.dart';

class ValidationModule extends AbstractModule {
  static const loginFormValidator = 'loginFormValidator';
  static const registrationFormValidator = 'registrationFormValidator';

  static const emailFieldValidator = 'emailFieldValidator';
  static const passwordFieldValidator = 'passwordFieldValidator';

  static final ValidationModule _validationModule =
      ValidationModule._internal();

  factory ValidationModule() {
    return _validationModule;
  }

  ValidationModule._internal();

  @override
  void configure(Injector injector) {
    injector.map(
      (i) => FieldValidator(InputFieldType.email, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorEmptyEmail,
        ),
        LengthValidationRule(
          error: SdStrings.fieldErrorPatternEmail,
        ),
      ]),
      key: emailFieldValidator,
    );

    injector.map(
      (i) => FieldValidator(InputFieldType.email, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorEmptyPassword,
        ),
        LengthValidationRule(
          error: SdStrings.fieldErrorPatternPassword,
          min: 6,
        ),
      ]),
      key: passwordFieldValidator,
    );

    injector.map(
        (i) => FormValidator({
              InputFieldType.email: i.get(key: emailFieldValidator),
              InputFieldType.password: i.get(key: passwordFieldValidator),
            }),
        key: loginFormValidator);
  }
}
