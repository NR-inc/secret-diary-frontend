import 'package:sd_base/sd_base.dart';
import 'package:sd_data/sd_data.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_data/src/mock/posts_data_mock_repository.dart';
import 'package:sddomain/repository/auth_repository.dart';
import 'package:sddomain/repository/config_repository.dart';
import 'package:sddomain/repository/posts_repository.dart';
import 'package:sddomain/repository/user_repository.dart';

class MockRepositoryModule extends AbstractModule {
  static final MockRepositoryModule _mockRepositoryModule =
      MockRepositoryModule._internal();

  factory MockRepositoryModule() {
    return _mockRepositoryModule;
  }

  MockRepositoryModule._internal();

  @override
  void configure(Injector injector) {
    injector.map<ConfigRepository>(
      (i) => ConfigDataMockRepository(),
      isSingleton: true,
    );

    injector.map<AuthRepository>(
      (i) => AuthDataMockRepository(),
      isSingleton: true,
    );

    injector.map<UserRepository>(
      (i) => UserDataMockRepository(),
      isSingleton: true,
    );

    injector.map<PostsRepository>(
      (i) => PostsDataMockRepository(),
      isSingleton: true,
    );
  }
}
