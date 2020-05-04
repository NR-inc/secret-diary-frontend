import 'package:sdbase/di/abstract_module.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddata/repository/auth_data_repository.dart';
import 'package:sddata/repository/config_data_repository.dart';
import 'package:sddata/repository/user_data_repository.dart';
import 'package:sddomain/repository/auth_repository.dart';
import 'package:sddomain/repository/config_repository.dart';
import 'package:sddomain/repository/user_repository.dart';

class RepositoryModule extends AbstractModule {
  static final RepositoryModule _repositoryModule =
      RepositoryModule._internal();

  factory RepositoryModule() {
    return _repositoryModule;
  }

  RepositoryModule._internal();

  @override
  void configure(Injector injector) {
    injector.map<ConfigRepository>((i) => ConfigDataRepository(i.get()),
        isSingleton: true);
    injector.map<AuthRepository>((i) => AuthDataRepository(i.get(), i.get()),
        isSingleton: true);
    injector.map<UserRepository>((i) => UserDataRepository(i.get(), i.get()),
        isSingleton: true);
  }
}
