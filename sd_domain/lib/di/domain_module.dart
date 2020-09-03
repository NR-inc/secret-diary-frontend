import 'package:sd_base/sd_base.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/export/domain.dart';

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
    ValidationModule().configure(injector);
  }
}
