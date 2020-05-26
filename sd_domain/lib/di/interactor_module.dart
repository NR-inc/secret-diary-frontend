import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sdbase/di/abstract_module.dart';
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
        i.get(
          key: ValidationModule.loginFormValidator,
        )));

    injector.map((i) => UserInteractor(i.get()));
  }
}
