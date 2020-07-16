import 'package:sd_base/sd_base.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_data/sd_data.dart';
import 'package:sddomain/di/domain_module.dart';

class InjectModule extends AbstractModule {
  static final InjectModule _injectModule = InjectModule._internal();
  AppConfigs _appConfigs;

  factory InjectModule(AppConfigs appConfigs) {
    return _injectModule.._appConfigs = appConfigs;
  }

  InjectModule._internal() {
    this.configure(Injector.getInjector());
  }

  @override
  void configure(Injector injector) {
    injector.map((i) => _appConfigs);
    DataModule().configure(injector);
    DomainModule().configure(injector);
  }
}
