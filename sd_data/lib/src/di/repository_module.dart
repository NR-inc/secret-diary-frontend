import 'package:sd_base/sd_base.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_data/src/repository/auth_data_repository.dart';
import 'package:sd_data/src/repository/config_data_repository.dart';
import 'package:sd_data/src/repository/posts_data_repository.dart';
import 'package:sd_data/src/repository/user_data_repository.dart';
import 'package:sddomain/repository/auth_repository.dart';
import 'package:sddomain/repository/config_repository.dart';
import 'package:sddomain/repository/posts_repository.dart';
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
    injector.map<ConfigRepository>(
      (i) => ConfigDataRepository(),
      isSingleton: true,
    );

    injector.map<AuthRepository>(
      (i) => AuthDataRepository(i.get()),
      isSingleton: true,
    );

    injector.map<UserRepository>(
      (i) => UserDataRepository(i.get()),
      isSingleton: true,
    );

    injector.map<PostsRepository>(
        (i) => PostsDataRepository(
              i.get(),
            ),
        isSingleton: true);
  }
}
