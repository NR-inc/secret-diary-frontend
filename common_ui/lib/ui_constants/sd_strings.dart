import 'package:common_ui/common_ui.dart';

class SdStrings {
  static const String empty = '';

  static const String login = 'Login';
  static const String registration = 'Registration';
  static const String remindPassword = 'Remind Password';

  /// BUTTONS
  static const String createPostButton = 'Create post';
  static const String forgotPasswordButton = 'Forgot password?';
  static const String sendPasswordResetLinkButton = 'Send password reset link';
  static const String submitButton = 'Submit';
  static const String cancelButton = 'Cancel';

  /// HINTS
  static const String firstNameHint = 'First name';
  static const String lastNameHint = 'Last name';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';
  static const String postTitleHint = 'Title';
  static const String postDescriptionHint = 'Description';
  static const String postVisibilityFlagHint = 'Show to everyone my post (anonymously)';

  /// MESSAGES
  static const String resetPasswordSuccessMessage = 'We have e-mailed your password reset link!';
  static const String userPostUpdateSuccessMsg = 'Your profile has been updated';
  static const String passwordRequiredTitleMsg = 'Password required';
  static const String passwordRequiredDescriptionMsg = 'Please enter your password';
  static const String resetMyPasswordMsg = 'Reset my password';

  /// ERRORS
  static const String fieldErrorMaxLength =
      "Field should not contain more than ${ValidationConstants.fieldMaxLength} characters";
  static const String fieldErrorMinLength =
      "Field should contain ${ValidationConstants.fieldMinLength} or more characters";

  static const String fieldErrorEmptyFirstName = "Please enter your first name";
  static const String fieldErrorPatternFirstName = "Invalid first name";

  static const String fieldErrorEmptyLastName = "Please enter your last name";
  static const String fieldErrorPatternLastName = "Invalid last name";

  static const String fieldErrorEmptyEmail = "Please enter your email";
  static const String fieldErrorPatternEmail = "Invalid email";

  static const String fieldErrorEmptyPassword = "Please enter a password";
  static const String fieldErrorMinLengthPassword =
      "Password should contain ${ValidationConstants.passwordMinLength} or more characters";
  static const String fieldErrorMaxLengthPassword =
      "Password should not contain more than ${ValidationConstants.passwordMaxLength} characters";
  static const String fieldErrorPatternPassword = "Invalid password";
  static const String fieldErrorWrongPassword = "Wrong password";

}
