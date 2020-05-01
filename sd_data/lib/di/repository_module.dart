import 'package:dio/dio.dart';
import 'package:sdbase/di/abstract_module.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddata/di/network_module.dart';
import 'package:sddata/repository/auth_data_repository.dart';
import 'package:sddata/repository/config_data_repository.dart';
import 'package:sddomain/repository/auth_repository.dart';
import 'package:sddomain/repository/config_repository.dart';

class RepositoryModule extends AbstractModule {
  static final RepositoryModule _repositoryModule =
      RepositoryModule._internal();

  factory RepositoryModule() {
    return _repositoryModule;
  }

  RepositoryModule._internal();

  @override
  void configure(Injector injector) {
    injector.map<ConfigRepository>((i) => ConfigDataRepository(),
        isSingleton: true);
    injector.map<AuthRepository>(
        (i) => AuthDataRepository(
            i.get(key: NetworkModule.dioAuthClientKey), i.get()),
        isSingleton: true);
  }
}
