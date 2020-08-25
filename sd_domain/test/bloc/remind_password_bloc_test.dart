import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mockito/mockito.dart';
import 'package:sddomain/bloc/remind_password_bloc.dart';
import 'package:sddomain/exceptions/common_exception.dart';
import 'package:sddomain/export/domain.dart';
import '../mock/mocks.dart';

void main() {
  group('Test remind password bloc', () {
    final email = 'email@gmail.com';

    test('Verify remind password is success ', () async {
      const expected = DefaultResponse.SUCCESS;
      final mockAuthInteractor = MockAuthInteractor();
      final remindPasswordSubject = PublishSubject<DefaultResponse>();
      final remindPasswordBloc = RemindPasswordBloc(
        mockAuthInteractor,
        remindPasswordSubject,
      );

      addTearDown(() {
        remindPasswordSubject.close();
      });

      when(
        mockAuthInteractor.remindPassword(email),
      ).thenAnswer((_) => Stream.value(expected));

      remindPasswordBloc.remindPassword(email);

      await expectLater(
        remindPasswordSubject,
        emits(expected),
      );
    });

    test('Verify registration throw error', () async {
      final expected = CommonException();
      final mockAuthInteractor = MockAuthInteractor();
      final remindPasswordSubject = PublishSubject<DefaultResponse>();
      final remindPasswordBloc = RemindPasswordBloc(
        mockAuthInteractor,
        remindPasswordSubject,
      );

      addTearDown(() {
        remindPasswordSubject.close();
      });

      when(
        mockAuthInteractor.remindPassword(email),
      ).thenAnswer((_) => Stream.error(expected));

      remindPasswordBloc.remindPassword(email);

      await expectLater(
        remindPasswordSubject,
        emitsError(expected),
      );
    });

    test('Verify loading when remind password is Success', () async {
      final expected = DefaultResponse.SUCCESS;
      final mockAuthInteractor = MockAuthInteractor();
      final remindPasswordSubject = PublishSubject<DefaultResponse>();
      final remindPasswordBloc =
          RemindPasswordBloc(mockAuthInteractor, remindPasswordSubject);

      addTearDown(() {
        remindPasswordSubject.close();
      });

      when(
        mockAuthInteractor.remindPassword(email),
      ).thenAnswer((_) => Stream.value(expected));

      scheduleMicrotask(() {
        remindPasswordBloc.remindPassword(email);
      });

      await expectLater(
        remindPasswordBloc.loadingProgress,
        emitsInOrder([true, false]),
      );
    });

    test('Verify loading when remind password throws ERROR', () async {
      final expected = CommonException();
      final mockAuthInteractor = MockAuthInteractor();
      final remindPasswordSubject = PublishSubject<DefaultResponse>();
      final remindPasswordBloc =
          RemindPasswordBloc(mockAuthInteractor, remindPasswordSubject);

      addTearDown(() {
        remindPasswordSubject.close();
      });

      when(
        mockAuthInteractor.remindPassword(email),
      ).thenAnswer((_) => Stream.error(expected));

      //scheduleMicrotask(() {
      remindPasswordBloc.remindPassword(email);
      //});

      await expectLater(
        remindPasswordBloc.loadingProgress,
        emitsInOrder([true, false]),
      );
    });
  });
}
