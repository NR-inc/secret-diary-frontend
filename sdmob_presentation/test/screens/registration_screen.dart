import 'package:common_ui/ui_constants/locators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'base_screen.dart';

class RegistrationScreen extends BaseScreen {
  RegistrationScreen(FlutterDriver flutterDriver)
      : super(
          flutterDriver,
          find.byValueKey(Locators.registrationScreenLocator),
        );

  SerializableFinder _firstNameField = find.byValueKey(
    Locators.firstNameFieldLocator,
  );
  SerializableFinder _firstNameErrorField = find.byValueKey(
    Locators.firstNameErrorLocator,
  );

  SerializableFinder _lastNameField = find.byValueKey(
    Locators.lastNameFieldLocator,
  );
  SerializableFinder _lastNameErrorField = find.byValueKey(
    Locators.lastNameErrorLocator,
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

  SerializableFinder _registrationButton = find.byValueKey(
    Locators.registrationButtonLocator,
  );

  Future<void> fillFirstName(String firstName) async {
    await flutterDriver.tap(_firstNameField);
    await flutterDriver.enterText(firstName);
  }

  Future<void> fillLastName(String lastName) async {
    await flutterDriver.tap(_lastNameField);
    await flutterDriver.enterText(lastName);
  }

  Future<void> fillEmail(String email) async {
    await flutterDriver.tap(_emailField);
    await flutterDriver.enterText(email);
  }

  Future<void> fillPassword(String password) async {
    await flutterDriver.tap(_passwordField);
    await flutterDriver.enterText(password);
  }

  Future<bool> isFirstNameErrorVisible() async => await isDisplayed(
        finder: _firstNameErrorField,
      );

  Future<bool> isLastNameErrorVisible() async => await isDisplayed(
        finder: _lastNameErrorField,
      );

  Future<bool> isEmailErrorVisible() async => await isDisplayed(
        finder: _emailErrorField,
      );

  Future<bool> isPasswordErrorVisible() async => await isDisplayed(
        finder: _passwordErrorField,
      );

  Future<bool> isRegistrationButtonVisible() async => await isDisplayed(
    finder: _registrationButton,
  );

  Future<void> tapRegistrationButton() async => await flutterDriver.tap(
        _registrationButton,
      );
}
