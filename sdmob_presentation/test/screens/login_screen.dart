import 'package:common_ui/ui_constants/locators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'base_screen.dart';

class LoginScreen extends BaseScreen {
  LoginScreen(FlutterDriver flutterDriver)
      : super(
          flutterDriver,
          find.byValueKey(Locators.loginScreenLocator),
        );

  SerializableFinder _emailField = find.byValueKey(
    Locators.emailFieldLocator,
  );
  SerializableFinder _emailErrorField = find.byValueKey(
    Locators.emailErrorLocator,
  );

  SerializableFinder _passwordField = find.byValueKey(
    Locators.passwordFieldLocator,
  );
  SerializableFinder _passwordErrorField = find.byValueKey(
    Locators.passwordErrorLocator,
  );

  SerializableFinder _loginButton = find.byValueKey(
    Locators.loginButtonLocator,
  );
  SerializableFinder _registrationButton = find.byValueKey(
    Locators.registrationButtonLocator,
  );

  Future<String> getEmailText() async => flutterDriver.getText(
        _emailField,
      );

  Future<String> getPasswordText() async => flutterDriver.getText(
        _passwordField,
      );

  Future<void> fillEmail(String email) async {
    await flutterDriver.tap(_emailField);
    await flutterDriver.enterText(email);
  }

  Future<void> fillPassword(String password) async {
    await flutterDriver.tap(_passwordField);
    await flutterDriver.enterText(password);
  }

  Future<bool> isEmailErrorVisible() async => await isDisplayed(
        finder: _emailErrorField,
      );

  Future<bool> isPasswordErrorVisible() async => await isDisplayed(
        finder: _passwordErrorField,
      );

  Future<bool> isRegistrationButtonVisible() async => await isDisplayed(
    finder: _registrationButton,
  );

  Future<void> tapLoginButton() async => await flutterDriver.tap(
        _loginButton,
      );

  Future<void> tapRegistrationButton() async => await flutterDriver.tap(
        _registrationButton,
      );
}
