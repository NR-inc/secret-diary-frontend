import 'dart:math';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import '../screens/diary_screen.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';
import '../utils/utils.dart';

void main() {
  group('Verify registration functionality', () {
    final correctFirstName = 'Test first name';
    final correctLastName = 'Test last name';
    final correctEmail = 'test.email${Random().nextInt(10000)}@email.com';
    final correctPassword = '1q2w3e4r5t';

    FlutterDriver flutterDriver;
    LoginScreen loginScreen;
    RegistrationScreen registrationScreen;
    DiaryScreen diaryScreen;

    setUpAll(() async {
      flutterDriver = await FlutterDriver.connect();
      loginScreen = LoginScreen(flutterDriver);
      registrationScreen = RegistrationScreen(flutterDriver);
      diaryScreen = DiaryScreen(flutterDriver);
    });

    tearDownAll(() async {
      if (flutterDriver != null) {
        flutterDriver.close();
      }
    });

    test(
      'Verify the login screen displaying',
      () async {
        await wait(Duration(seconds: 15));

        print('Verify that login screen is displayed');
        expect(
          await loginScreen.isReady(),
          true,
        );

        print('Verify that login button is displayed');
        expect(
          await loginScreen.isRegistrationButtonVisible(),
          true,
        );

        print('Tap on the registration button');
        await loginScreen.tapRegistrationButton();
      },
    );

    test(
      'Verify the registration screen displaying',
      () async {
        print('Verify the registration screen displaying');
        await registrationScreen.isReady();

        print('Verify that registration button is displayed');
        expect(
          await registrationScreen.isRegistrationButtonVisible(),
          true,
        );

        print('Tap on the registration button');
        await registrationScreen.tapRegistrationButton();
      },
    );

    test(
      'Verify displaying validation errors on the registration screen',
      () async {
        print('Verify first name error is visible');
        expect(
          await registrationScreen.isFirstNameErrorVisible(),
          true,
        );

        print('Verify last name error is visible');
        expect(
          await registrationScreen.isLastNameErrorVisible(),
          true,
        );

        print('Verify email error is visible');
        expect(
          await registrationScreen.isEmailErrorVisible(),
          true,
        );

        print('Verify password error is visible');
        expect(
          await registrationScreen.isPasswordErrorVisible(),
          true,
        );
      },
    );

    test(
      'Verify text fisplaying in the registration screen fields',
      () async {
        print('Input first name');
        await registrationScreen.fillFirstName(correctFirstName);

        print('Veify that inputed first name is displayed');
        expect(
          await registrationScreen.isDisplayed(text: correctFirstName),
          true,
        );

        print('Input last name');
        await registrationScreen.fillLastName(correctLastName);

        print('Veify that inputed last name is displayed');
        expect(
          await registrationScreen.isDisplayed(text: correctLastName),
          true,
        );

        print('Input email');
        await registrationScreen.fillEmail(correctEmail);

        print('Veify that inputed email is displayed');
        expect(
          await registrationScreen.isDisplayed(text: correctEmail),
          true,
        );

        print('Input password');
        await registrationScreen.fillPassword(correctPassword);

        print('Veify that inputed password is displayed');
        expect(
          await registrationScreen.isDisplayed(text: correctPassword),
          true,
        );
      },
    );

    test(
      'Verify registration is successful',
      () async {
        print('Tap on the registration button');
        await registrationScreen.tapRegistrationButton();

        print('Verify the diary screen is displayed');
        expect(
          await diaryScreen.isReady(
            timeout: Duration(minutes: 1),
          ),
          true,
        );
      },
    );
  });
}
