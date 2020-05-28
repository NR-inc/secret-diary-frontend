import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sddomain/exceptions/network_exception.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/export/domain.dart';
import '../mock/mocks.dart';

void main() {
  group('AuthInteractor test', () {
    const token = 'token';
    const firstName = 'firstName';
    const lastName = 'lastName';
    const email = 'email@test.com';
    const password = 'dsf24cdsfsdfc';

    test('Verify login is success', () async {
      final authTokenModel = AuthTokenModel(token);
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );

      const expected = DefaultResponse.SUCCESS;

      when(
        loginFormValidator.validateForm(any),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      when(
        authRepo.login(email, password),
      ).thenAnswer(
        (_) => Stream.value(authTokenModel),
      );

      when(
        configRepo.saveAuthToken(authTokenModel),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      await expectLater(
        authInteractor.login(email, password),
        emits(expected),
      );

      verify(loginFormValidator.validateForm(any));
      verify(configRepo.saveAuthToken(authTokenModel));
    });

    test('Verify login throws network error', () async {
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );

      final expected = NetworkException();

      when(
        authRepo.login(email, password),
      ).thenAnswer(
        (_) => Stream.error(expected),
      );

      when(
        loginFormValidator.validateForm(any),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      await expectLater(
        authInteractor.login(email, password),
        emitsError(expected),
      );

      verify(loginFormValidator.validateForm(any));
      verifyNever(configRepo.saveAuthToken(any));
    });

    test('Verify login throws validation error', () async {
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );

      final expected = ValidationException();

      when(
        loginFormValidator.validateForm(any),
      ).thenAnswer(
        (_) => Future<void>.error(expected),
      );

      await expectLater(
        authInteractor.login(email, password),
        emitsError(expected),
      );

      verify(loginFormValidator.validateForm(any));
      verifyNever(configRepo.saveAuthToken(any));
    });

    test('Verify registration is success', () async {
      final authTokenModel = AuthTokenModel(token);
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );

      const expected = DefaultResponse.SUCCESS;

      when(
        registrationFormValidator.validateForm(any),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      when(
        authRepo.registration(firstName, lastName, email, password),
      ).thenAnswer(
        (_) => Stream.value(authTokenModel),
      );

      when(
        configRepo.saveAuthToken(authTokenModel),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      await expectLater(
        authInteractor.registration(firstName, lastName, email, password),
        emits(expected),
      );

      verify(registrationFormValidator.validateForm(any));
      verify(configRepo.saveAuthToken(authTokenModel));
    });

    test('Verify registration throws network error', () async {
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );

      final expected = NetworkException();

      when(
        authRepo.registration(firstName, lastName, email, password),
      ).thenAnswer(
        (_) => Stream.error(expected),
      );

      when(
        registrationFormValidator.validateForm(any),
      ).thenAnswer(
        (_) => Future<void>.value(),
      );

      await expectLater(
        authInteractor.registration(firstName, lastName, email, password),
        emitsError(expected),
      );

      verify(registrationFormValidator.validateForm(any));
      verifyNever(configRepo.saveAuthToken(any));
    });

    test('Verify registration throws validation error', () async {
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );

      final expected = ValidationException();

      when(
        registrationFormValidator.validateForm(any),
      ).thenAnswer(
        (_) => Future<void>.error(expected),
      );

      await expectLater(
        authInteractor.registration(firstName, lastName, email, password),
        emitsError(expected),
      );

      verify(registrationFormValidator.validateForm(any));
      verifyNever(configRepo.saveAuthToken(any));
    });

    test('Verify logout is success', () async {
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );

      await authInteractor.logout();

      verify(userRepo.logout());
      verify(configRepo.clearAuthToken());
    });

    test('Verify session check', () async {
      final loginFormValidator = MockFormValidator();
      final registrationFormValidator = MockFormValidator();
      final authRepo = MockAuthRepository();
      final configRepo = MockConfigRepository();
      final userRepo = MockUserRepository();
      final authInteractor = AuthInteractor(
        configRepo,
        authRepo,
        userRepo,
        loginFormValidator,
        registrationFormValidator,
      );


      when(
        configRepo.hasSession(),
      ).thenAnswer(
        (_) => Future.value(true),
      );

      final expected = true;

      expect(
        await authInteractor.hasSession(),
        expected,
      );
    });
  });
}
