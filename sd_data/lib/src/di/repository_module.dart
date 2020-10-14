import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sd_base/sd_base.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_data/sd_data.dart';
import 'package:sd_data/src/repository/auth_data_repository.dart';
import 'package:sd_data/src/repository/config_data_repository.dart';
import 'package:sd_data/src/repository/likes_data_repository.dart';
import 'package:sd_data/src/repository/posts_data_repository.dart';
import 'package:sd_data/src/repository/user_data_repository.dart';
import 'package:sddomain/export/domain.dart';
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
    injector.map<CommentsRepository>(
      (i) => CommentsDataRepository(
        errorHandler: i.get(),
        firestore: FirebaseFirestore.instance,
      ),
      isSingleton: true,
    );
    injector.map<LikesRepository>(
      (i) => LikesDataRepository(
        errorHandler: i.get(),
        firestore: FirebaseFirestore.instance,
      ),
      isSingleton: true,
    );

    injector.map<ConfigRepository>(
      (i) => ConfigDataRepository(),
      isSingleton: true,
    );

    injector.map<AuthRepository>(
      (i) => AuthDataRepository(
        errorHandler: i.get(),
        firebaseAuth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      ),
      isSingleton: true,
    );

    injector.map<UserRepository>(
      (i) => UserDataRepository(
        errorHandler: i.get(),
        firebaseAuth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      ),
      isSingleton: true,
    );

    injector.map<PostsRepository>(
        (i) => PostsDataRepository(
              errorHandler: i.get(),
              firestore: FirebaseFirestore.instance,
            ),
        isSingleton: true);
  }
}
