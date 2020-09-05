import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:rxdart/subjects.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/bloc/login_bloc.dart';
import 'package:sddomain/bloc/posts_bloc.dart';
import 'package:sddomain/bloc/registration_bloc.dart';
import 'package:sddomain/bloc/settings_bloc.dart';
import 'package:sddomain/bloc/splash_bloc.dart';
import 'package:sddomain/bloc/user_bloc.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/model/default_response.dart';

class BlocModule extends AbstractModule {
  static final BlocModule _blocModule = BlocModule._internal();

  factory BlocModule() {
    return _blocModule;
  }

  BlocModule._internal();

  @override
  void configure(Injector injector) {
    injector.map((i) => SplashBloc(
          i.get(),
        ));
    injector.map((i) => RegistrationBloc(
          i.get(),
          PublishSubject<DefaultResponse>(),
        ));
    injector.map((i) => LoginBloc(
          i.get(),
          PublishSubject<DefaultResponse>(),
        ));
    injector.map((i) => SettingsBloc(i.get()));
    injector.map((i) => UserBloc(i.get()));

    injector.map((i) => PostsBloc(
          i.get(),
          PublishSubject<List<PostModel>>(),
          PublishSubject<bool>(),
        ));
  }
}
