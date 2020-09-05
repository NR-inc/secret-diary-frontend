import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sddomain/bloc/login_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:sddomain/exceptions/common_exception.dart';
import 'package:sddomain/export/domain.dart';

import '../mock/interactors.dart';

void main() {
  group('Test login bloc', () {
    final email = 'email@gmail.com';
    final password = 'pdaqe21x';

    test('Verify login is success ', () async {
      const expected = DefaultResponse.SUCCESS;
      final mockAuthInteractor = MockAuthInteractor();
      final loginSubject = PublishSubject<DefaultResponse>();
      final loginBloc = LoginBloc(mockAuthInteractor, loginSubject);

      addTearDown(() {
        loginSubject.close();
      });

      when(
        mockAuthInteractor.login(email, password),
      ).thenAnswer((_) => Stream.value(expected));

      loginBloc.login(email, password);

      await expectLater(loginSubject, emits(expected));
    });

    test('Verify login thows error', () async {
      final expected = CommonException();
      final mockAuthInteractor = MockAuthInteractor();
      final loginSubject = PublishSubject<DefaultResponse>();
      final loginBloc = LoginBloc(mockAuthInteractor, loginSubject);

      addTearDown(() {
        loginSubject.close();
      });

      when(
        mockAuthInteractor.login(email, password),
      ).thenAnswer((_) => Stream.error(expected));

      loginBloc.login(email, password);

      await expectLater(loginSubject, emitsError(expected));
    });

    test('Verify loading when login is SUCCESS ', () async {
      const expected = DefaultResponse.SUCCESS;
      final mockAuthInteractor = MockAuthInteractor();
      final loginSubject = PublishSubject<DefaultResponse>();
      final loginBloc = LoginBloc(mockAuthInteractor, loginSubject);

      addTearDown(() {
        loginSubject.close();
      });

      when(
        mockAuthInteractor.login(email, password),
      ).thenAnswer((_) => Stream.value(expected));

      scheduleMicrotask((){
        loginBloc.login(email, password);
      });

      await expectLater(loginBloc.loadingProgressStream, emitsInOrder([true, false]));
    });

    test('Verify loading when login throws ERROR', () async {
      final expected = CommonException();
      final mockAuthInteractor = MockAuthInteractor();
      final loginSubject = PublishSubject<DefaultResponse>();
      final loginBloc = LoginBloc(mockAuthInteractor, loginSubject);

      addTearDown(() {
        loginSubject.close();
      });

      when(
        mockAuthInteractor.login(email, password),
      ).thenAnswer((_) => Stream.error(expected));

      scheduleMicrotask((){
        loginBloc.login(email, password);
      });

      await expectLater(loginBloc.loadingProgressStream, emitsInOrder([true, false]));
    });
  });
}
