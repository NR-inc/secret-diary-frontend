import 'package:sddomain/core/constants/constants.dart';

class SdStrings {
  static const String empty = '';

  static const String login = 'Login';
  static const String registration = 'Registration';

  /// HINTS
  static const String firstNameHint = 'First name';
  static const String lastNameHint = 'Last name';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';

  /// ERRORS
  static const String fieldErrorMaxLength =
      "Field should not contain more than ${Constants.fieldMaxLength} characters";
  static const String fieldErrorMinLength =
      "Field should contain ${Constants.fieldMinLength} or more characters";

  static const String fieldErrorEmptyFirstName = "Please enter your first name";
  static const String fieldErrorPatternFirstName = "Invalid first name";

  static const String fieldErrorEmptyLastName = "Please enter your last name";
  static const String fieldErrorPatternLastName = "Invalid last name";

  static const String fieldErrorEmptyEmail = "Please enter your email";
  static const String fieldErrorPatternEmail = "Invalid email";

  static const String fieldErrorEmptyPassword = "Please enter a password";
  static const String fieldErrorMinLengthPassword =
      "Password should contain ${Constants.passwordMinLength} or more characters";
  static const String fieldErrorMaxLengthPassword =
      "Password should not contain more than ${Constants.passwordMaxLength} characters";
  static const String fieldErrorPatternPassword = "Invalid password";
}