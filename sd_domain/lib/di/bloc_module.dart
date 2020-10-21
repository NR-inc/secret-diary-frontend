import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:rxdart/subjects.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/bloc/comments_bloc.dart';
import 'package:sddomain/bloc/likes_bloc.dart';
import 'package:sddomain/bloc/login_bloc.dart';
import 'package:sddomain/bloc/posts_bloc.dart';
import 'package:sddomain/bloc/registration_bloc.dart';
import 'package:sddomain/bloc/settings_bloc.dart';
import 'package:sddomain/bloc/splash_bloc.dart';
import 'package:sddomain/bloc/user_bloc.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/model/default_response.dart';

class BlocModule extends AbstractModule {
  static final BlocModule _blocModule = BlocModule._internal();

  factory BlocModule() {
    return _blocModule;
  }

  BlocModule._internal();

  @override
  void configure(Injector injector) {
    injector.map((i) => CommentsBloc(
          logger: i.get(),
          commentsResult: BehaviorSubject<List<CommentModel>>.seeded(List()),
          interactor: i.get(),
        ));

    injector.map((i) => LikesBloc(
          likesResult: BehaviorSubject<List<LikeModel>>.seeded(List()),
          isPostLikedResult: BehaviorSubject<bool>.seeded(false),
          logger: i.get(),
          interactor: i.get(),
        ));

    injector.map((i) => SplashBloc(
          logger: i.get(),
          authInteractor: i.get(),
        ));

    injector.map((i) => RegistrationBloc(
          logger: i.get(),
          authInteractor: i.get(),
          registrationResult: PublishSubject<DefaultResponse>(),
        ));

    injector.map((i) => LoginBloc(
          logger: i.get(),
          authInteractor: i.get(),
          loginSubject: PublishSubject<DefaultResponse>(),
        ));

    injector.map((i) => SettingsBloc(
          logger: i.get(),
          authInteractor: i.get(),
        ));

    injector.map((i) => UserBloc(
          logger: i.get(),
          userInteractor: i.get(),
        ));

    injector.map((i) => PostsBloc(
          logger: i.get(),
          postsInteractor: i.get(),
          postsResult: BehaviorSubject<List<PostModel>>.seeded(List()),
          postCreationResult: PublishSubject<bool>(),
          postDetailsResult: PublishSubject<PostModel>(),
        ));

    injector.map((i) => RemindPasswordBloc(
          logger: i.get(),
          authInteractor: i.get(),
          remindPasswordResult: PublishSubject<DefaultResponse>(),
        ));
  }
}
