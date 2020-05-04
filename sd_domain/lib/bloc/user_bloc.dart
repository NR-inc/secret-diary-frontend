import 'package:rxdart/subjects.dart';
import 'package:sddomain/bloc/base_bloc.dart';
import 'package:sddomain/interactor/user_interactor.dart';
import 'package:sddomain/model/user_model.dart';

class UserBloc implements BaseBloc {
  final UserInteractor _userInteractor;
  final currentUserSubject = BehaviorSubject<UserModel>();

  UserBloc(this._userInteractor);

  void profile() async {
    final currentUser = await _userInteractor.profile();
    currentUserSubject.add(currentUser);
  }

  @override
  void dispose() {
    currentUserSubject.close();
  }

  @override
  void unsubscribe() {
    // TODO: implement unsubscribe
  }
}
