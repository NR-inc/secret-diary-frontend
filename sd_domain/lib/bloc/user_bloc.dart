import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/user_interactor.dart';
import 'package:sddomain/model/user_model.dart';

class UserBloc extends BaseBloc {
  final UserInteractor _userInteractor;
  final currentUserSubject = BehaviorSubject<UserModel>();

  UserBloc({
    @required Logger logger,
    @required UserInteractor userInteractor,
  })  : _userInteractor = userInteractor,
        super(logger: null);

  void profile() async {
    final currentUser = await _userInteractor.profile();
    currentUserSubject.add(currentUser);
  }

  @override
  void dispose() {
    super.dispose();
    currentUserSubject.close();
  }
}
