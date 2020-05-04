import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sdbase/di/abstract_module.dart';
import 'package:sddomain/bloc/login_bloc.dart';
import 'package:sddomain/bloc/registration_bloc.dart';
import 'package:sddomain/bloc/settings_bloc.dart';
import 'package:sddomain/bloc/splash_bloc.dart';
import 'package:sddomain/bloc/user_bloc.dart';

class BlocModule extends AbstractModule {
  static final BlocModule _blocModule = BlocModule._internal();

  factory BlocModule() {
    return _blocModule;
  }

  BlocModule._internal();

  @override
  void configure(Injector injector) {
    injector.map((i) => SplashBloc(i.get()));
    injector.map((i) => RegistrationBloc(i.get()));
    injector.map((i) => LoginBloc(i.get()));
    injector.map((i) => SettingsBloc(i.get()));
    injector.map((i) => UserBloc(i.get()));
  }
}
