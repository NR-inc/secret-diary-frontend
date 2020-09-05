import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/export/domain.dart';

class InteractorModule extends AbstractModule {
  static final InteractorModule _interactorModule =
      InteractorModule._internal();

  factory InteractorModule() {
    return _interactorModule;
  }

  InteractorModule._internal();

  @override
  void configure(Injector injector) {
    injector.map((i) => AuthInteractor(
          i.get(),
          i.get(),
          i.get(),
          i.get(key: ValidationModule.loginFormValidator),
          i.get(key: ValidationModule.registrationFormValidator),
        ));

    injector.map(
      (i) => UserInteractor(i.get(), i.get()),
      isSingleton: true,
    );

    injector.map(
      (i) => PostsInteractor(
        i.get(),
        i.get(),
      ),
      isSingleton: true,
    );
  }
}
