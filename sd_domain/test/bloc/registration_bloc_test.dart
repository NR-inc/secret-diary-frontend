import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mockito/mockito.dart';
import 'package:sddomain/bloc/registration_bloc.dart';
import 'package:sddomain/exceptions/common_exception.dart';
import 'package:sddomain/export/domain.dart';
import '../mock/mocks.dart';

void main() {
  group('Test registration bloc', () {
    final firstName = 'first name';
    final lastName = 'last name';
    final email = 'email@gmail.com';
    final password = 'pdaqe21x';

    test('Verify registration is success ', () async {
      const expected = DefaultResponse.SUCCESS;
      final mockAuthInteractor = MockAuthInteractor();
      final registrationSubject = PublishSubject<DefaultResponse>();
      final registrationBloc = RegistrationBloc(
        mockAuthInteractor,
        registrationSubject,
      );

      addTearDown(() {
        registrationSubject.close();
      });

      when(
        mockAuthInteractor.registration(firstName, lastName, email, password),
      ).thenAnswer((_) => Stream.value(expected));

      registrationBloc.registration(firstName, lastName, email, password);

      await expectLater(
        registrationSubject,
        emits(expected),
      );
    });

    test('Verify registration throw error', () async {
      final expected = CommonException();
      final mockAuthInteractor = MockAuthInteractor();
      final registrationSubject = PublishSubject<DefaultResponse>();
      final registrationBloc = RegistrationBloc(
        mockAuthInteractor,
        registrationSubject,
      );

      addTearDown(() {
        registrationSubject.close();
      });

      when(
        mockAuthInteractor.registration(firstName, lastName, email, password),
      ).thenAnswer((_) => Stream.error(expected));

      registrationBloc.registration(firstName, lastName, email, password);

      await expectLater(
        registrationSubject,
        emitsError(expected),
      );
    });

    test('Verify loading when registration is SUCCESS', () async {
      const expected = DefaultResponse.SUCCESS;
      final mockAuthInteractor = MockAuthInteractor();
      final registrationSubject = PublishSubject<DefaultResponse>();
      final registrationBloc = RegistrationBloc(
        mockAuthInteractor,
        registrationSubject,
      );

      addTearDown(() {
        registrationSubject.close();
      });

      when(
        mockAuthInteractor.registration(firstName, lastName, email, password),
      ).thenAnswer((_) => Stream.value(expected));

      scheduleMicrotask(() {
        registrationBloc.registration(firstName, lastName, email, password);
      });

      await expectLater(
        registrationBloc.loadingProgress,
        emitsInOrder([true, false]),
      );
    });

    test('Verify loading when registration throws ERROR', () async {
      final expected = CommonException();
      final mockAuthInteractor = MockAuthInteractor();
      final registrationSubject = PublishSubject<DefaultResponse>();
      final registrationBloc =
          RegistrationBloc(mockAuthInteractor, registrationSubject);

      addTearDown(() {
        registrationSubject.close();
      });

      when(
        mockAuthInteractor.registration(firstName, lastName, email, password),
      ).thenAnswer((_) => Stream.error(expected));

      scheduleMicrotask(() {
        registrationBloc.registration(firstName, lastName, email, password);
      });

      await expectLater(
        registrationBloc.loadingProgress,
        emitsInOrder([true, false]),
      );
    });
  });
}
