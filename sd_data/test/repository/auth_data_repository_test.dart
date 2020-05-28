import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sddata/data.dart';
import 'package:sddomain/exceptions/network_exception.dart';
import 'package:sddomain/export/domain.dart';
import '../mocks/mocks.dart';

void main() {
  group('AuthRepository test', () {
    const token = 'test@test.com';
    const firstName = 'first name';
    const lastName = 'last name';
    const email = 'test@test.com';
    const password = '123456';
    final response = 'some json response';

    test('Login success test', () async {
      final networkClient = MockNetworkClient();
      final networkExecutor = MockNetworkExecutor();
      final mockLoginResponseMapper = MockLoginResponseMapper();
      final mockRegistrationResponseMapper = MockRegistrationResponseMapper();
      final authRepo = AuthDataRepository(
        networkClient,
        networkExecutor,
        mockLoginResponseMapper,
        mockRegistrationResponseMapper,
      );
      final expected = AuthTokenModel(token);
      when(
        networkExecutor.makeRequest(networkClient, any),
      ).thenAnswer((_) => Stream.value(response));

      when(
        mockLoginResponseMapper.map(response),
      ).thenAnswer((_) => expected);
      final actual = authRepo.login(
        email,
        password,
      );

      await expectLater(actual, emits(expected));
    });

    test('Login network error test', () async {
      final networkClient = MockNetworkClient();
      final networkExecutor = MockNetworkExecutor();
      final mockLoginResponseMapper = MockLoginResponseMapper();
      final mockRegistrationResponseMapper = MockRegistrationResponseMapper();
      final authRepo = AuthDataRepository(
        networkClient,
        networkExecutor,
        mockLoginResponseMapper,
        mockRegistrationResponseMapper,
      );
      final expected = NetworkException();
      when(
        networkExecutor.makeRequest(networkClient, any),
      ).thenAnswer((_) => Stream.error(expected));
      final actual = authRepo.login(
        email,
        password,
      );

      await expectLater(actual, emitsError(expected));
    });

    test('Registration success test', () async {
      final networkClient = MockNetworkClient();
      final networkExecutor = MockNetworkExecutor();
      final mockLoginResponseMapper = MockLoginResponseMapper();
      final mockRegistrationResponseMapper = MockRegistrationResponseMapper();
      final authRepo = AuthDataRepository(
        networkClient,
        networkExecutor,
        mockLoginResponseMapper,
        mockRegistrationResponseMapper,
      );
      final expected = AuthTokenModel(token);
      when(
        networkExecutor.makeRequest(networkClient, any),
      ).thenAnswer((_) => Stream.value(response));
      when(
        mockRegistrationResponseMapper.map(response),
      ).thenAnswer((_) => expected);
      final actual = authRepo.registration(
        firstName,
        lastName,
        email,
        password,
      );

      await expectLater(actual, emits(expected));
    });

    test('Registration network error test', () async {
      final networkClient = MockNetworkClient();
      final networkExecutor = MockNetworkExecutor();
      final mockLoginResponseMapper = MockLoginResponseMapper();
      final mockRegistrationResponseMapper = MockRegistrationResponseMapper();
      final authRepo = AuthDataRepository(
        networkClient,
        networkExecutor,
        mockLoginResponseMapper,
        mockRegistrationResponseMapper,
      );
      final expected = NetworkException();
      when(
        networkExecutor.makeRequest(networkClient, any),
      ).thenAnswer((_) => Stream.error(expected));
      final actual = authRepo.registration(
        firstName,
        lastName,
        email,
        password,
      );

      await expectLater(actual, emitsError(expected));
    });
  });
}
