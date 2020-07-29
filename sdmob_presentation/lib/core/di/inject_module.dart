import 'package:sd_base/sd_base.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_data/sd_data.dart';
import 'package:sddomain/di/domain_module.dart';

class InjectModule extends AbstractModule {
  static InjectModule _injectModule;
  AppConfigs _appConfigs;

  factory InjectModule(AppConfigs appConfigs) {
    if (_injectModule == null) {
      _injectModule = InjectModule._internal(appConfigs);
      return _injectModule;
    }
    return _injectModule;
  }

  InjectModule._internal(AppConfigs appConfigs) {
    _appConfigs = appConfigs;
    this.configure(Injector.getInjector());
  }

  @override
  void configure(Injector injector) {
    print('Build type: ${_appConfigs?.buildType?.toString()}');

    injector.map(
      (i) => _appConfigs,
      isSingleton: true,
    );
    DataModule().configure(injector);
    DomainModule().configure(injector);
  }
}
