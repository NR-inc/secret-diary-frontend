import 'package:sd_base/sd_base.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_data/src/di/network_module.dart';
import 'package:sd_data/src/di/repository_module.dart';

class DataModule extends AbstractModule {
  static final DataModule _dataModule = DataModule._internal();

  factory DataModule() {
    return _dataModule;
  }

  DataModule._internal();

  @override
  void configure(Injector injector) {
    NetworkModule().configure(injector);
    RepositoryModule().configure(injector);
  }
}
