import 'package:sdbase/di/abstract_module.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/di/bloc_module.dart';
import 'package:sddomain/di/interactor_module.dart';

class DomainModule extends AbstractModule {
  static final DomainModule _domainModule = DomainModule._internal();

  factory DomainModule() {
    return _domainModule;
  }

  DomainModule._internal();

  @override
  void configure(Injector injector) {
    BlocModule().configure(injector);
    InteractorModule().configure(injector);
  }
}
