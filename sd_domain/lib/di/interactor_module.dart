import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/interactor/likes_interactor.dart';

class InteractorModule extends AbstractModule {
  static final InteractorModule _interactorModule =
      InteractorModule._internal();

  factory InteractorModule() {
    return _interactorModule;
  }

  InteractorModule._internal();

  @override
  void configure(Injector injector) {
    injector.map(
      (i) => LikesInteractor(
        likesRepository: i.get(),
        userRepository: i.get(),
      ),
      isSingleton: true,
    );
    injector.map(
      (i) => CommentsInteractor(
        commentsRepository: i.get(),
        userRepository: i.get(),
      ),
      isSingleton: true,
    );

    injector.map(
      (i) => AuthInteractor(
          i.get(),
          i.get(),
          i.get(),
          i.get(key: ValidationModule.loginFormValidator),
          i.get(key: ValidationModule.registrationFormValidator),
          i.get(key: ValidationModule.remindPasswordFormValidator)),
    );

    injector.map((i) => UserInteractor(
          i.get(),
          i.get(key: ValidationModule.editProfileFormValidator),
        ));

    injector.map(
      (i) => PostsInteractor(
        postsRepository: i.get(),
        userRepository: i.get(),
        commentsRepository: i.get(),
        likesRepository: i.get(),
      ),
      isSingleton: true,
    );
  }
}
