import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sdbase/di/abstract_module.dart';
import 'package:sddomain/core/validation/rules/length_validation_rule.dart';
import 'package:sddomain/export/domain.dart';

class ValidationModule extends AbstractModule {
  static const loginFormValidator = 'loginFormValidator';
  static const registrationFormValidator = 'registrationFormValidator';

  static const firstNameFieldValidator = 'firstNameFieldValidator';
  static const lastNameFieldValidator = 'lastNameFieldValidator';
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
    _injectFirstNameFieldValidator(injector);
    _injectLastNameFieldValidator(injector);
    _injectEmailFieldValidator(injector);
    _injectPasswordFieldValidator(injector);

    injector.map(
      (i) => FormValidator({
        InputFieldType.email: i.get(key: emailFieldValidator),
        InputFieldType.password: i.get(key: passwordFieldValidator),
      }),
      key: loginFormValidator,
    );

    injector.map(
      (i) => FormValidator({
        InputFieldType.firstName: i.get(key: firstNameFieldValidator),
        InputFieldType.lastName: i.get(key: lastNameFieldValidator),
        InputFieldType.email: i.get(key: emailFieldValidator),
        InputFieldType.password: i.get(key: passwordFieldValidator),
      }),
      key: registrationFormValidator,
    );
  }

  void _injectFirstNameFieldValidator(Injector injector) {
    injector.map(
      (i) => FieldValidator(InputFieldType.firstName, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorEmptyFirstName,
        ),
        LengthValidationRule(),
      ]),
      key: firstNameFieldValidator,
    );
  }

  void _injectLastNameFieldValidator(Injector injector) {
    injector.map(
      (i) => FieldValidator(InputFieldType.lastName, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorEmptyLastName,
        ),
        LengthValidationRule(),
      ]),
      key: lastNameFieldValidator,
    );
  }

  void _injectEmailFieldValidator(Injector injector) {
    injector.map(
      (i) => FieldValidator(InputFieldType.email, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorEmptyEmail,
        ),
        LengthValidationRule(),
      ]),
      key: emailFieldValidator,
    );
  }

  void _injectPasswordFieldValidator(Injector injector) {
    injector.map(
      (i) => FieldValidator(InputFieldType.password, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorEmptyPassword,
        ),
        LengthValidationRule(
          minError: SdStrings.fieldErrorMinLengthPassword,
          maxError: SdStrings.fieldErrorMaxLengthPassword,
          min: Constants.passwordMinLength,
          max: Constants.passwordMaxLength,
        ),
      ]),
      key: passwordFieldValidator,
    );
  }
}
