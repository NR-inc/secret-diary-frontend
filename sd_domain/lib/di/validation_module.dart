import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/core/validation/rules/length_validation_rule.dart';
import 'package:sddomain/export/domain.dart';
import 'package:common_ui/common_ui.dart';

class ValidationModule extends AbstractModule {
  static const loginFormValidator = 'loginFormValidator';
  static const registrationFormValidator = 'registrationFormValidator';
  static const remindPasswordFormValidator = 'remindPasswordFormValidator';
  static const editProfileFormValidator = 'editProfileFormValidator';
  static const changePasswordFormValidator = 'changePasswordFormValidator';

  static const _firstNameFieldValidator = 'firstNameFieldValidator';
  static const _lastNameFieldValidator = 'lastNameFieldValidator';
  static const _emailFieldValidator = 'emailFieldValidator';
  static const _passwordFieldValidator = 'passwordFieldValidator';
  static const _passwordRequiredFieldValidator =
      'passwordRequiredFieldValidator';

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
    _injectPasswordRequiredFieldValidator(injector);

    injector.map(
      (i) => FormValidator({
        InputFieldType.email: i.get(key: _emailFieldValidator),
        InputFieldType.password: i.get(key: _passwordFieldValidator),
      }),
      key: loginFormValidator,
    );

    injector.map(
      (i) => FormValidator({
        InputFieldType.firstName: i.get(key: _firstNameFieldValidator),
        InputFieldType.lastName: i.get(key: _lastNameFieldValidator),
        InputFieldType.email: i.get(key: _emailFieldValidator),
        InputFieldType.password: i.get(key: _passwordFieldValidator),
      }),
      key: registrationFormValidator,
    );

    injector.map(
      (i) => FormValidator({
        InputFieldType.email: i.get(key: _emailFieldValidator),
      }),
      key: remindPasswordFormValidator,
    );

    injector.map(
      (i) => FormValidator({
        InputFieldType.password: i.get(key: _passwordFieldValidator),
      }),
      key: changePasswordFormValidator,
    );

    injector.map(
      (i) => FormValidator({
        InputFieldType.firstName: i.get(key: _firstNameFieldValidator),
        InputFieldType.lastName: i.get(key: _lastNameFieldValidator),
        InputFieldType.email: i.get(key: _emailFieldValidator),
        InputFieldType.password: i.get(key: _passwordRequiredFieldValidator),
      }),
      key: editProfileFormValidator,
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
      key: _firstNameFieldValidator,
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
      key: _lastNameFieldValidator,
    );
  }

  void _injectEmailFieldValidator(Injector injector) {
    injector.map(
      (i) => FieldValidator(InputFieldType.email, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorEmptyEmail,
        ),
        PatternValidationRule(
          pattern: ValidationPatterns.emailPattern,
          error: SdStrings.fieldErrorPatternEmail,
        ),
        LengthValidationRule(),
      ]),
      key: _emailFieldValidator,
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
          min: ValidationConstants.passwordMinLength,
          max: ValidationConstants.passwordMaxLength,
        ),
      ]),
      key: _passwordFieldValidator,
    );
  }

  void _injectPasswordRequiredFieldValidator(Injector injector) {
    injector.map(
      (i) => FieldValidator(InputFieldType.password, [
        EmptyValidationRule(
          error: SdStrings.fieldErrorWrongPassword,
        ),
        LengthValidationRule(
          minError: SdStrings.fieldErrorMinLengthPassword,
          maxError: SdStrings.fieldErrorMaxLengthPassword,
          min: ValidationConstants.passwordRequiredMinLength,
          max: ValidationConstants.passwordMaxLength,
        ),
      ]),
      key: _passwordRequiredFieldValidator,
    );
  }
}
