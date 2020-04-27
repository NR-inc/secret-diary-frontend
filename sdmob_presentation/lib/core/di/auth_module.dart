import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sdbase/di/abstract_module.dart';
import 'package:ssecretdiary/feature/auth/login/login_bloc.dart';

class AuthModule extends AbstractModule {
  static final AuthModule _authModule = AuthModule._internal();

  factory AuthModule() {
    return _authModule;
  }

  AuthModule._internal(){
    this.configure(Injector.getInjector());
  }

  @override
  void configure(Injector injector) {
    injector.map<LoginBloc>((i) => LoginBloc(), isSingleton: true);
  }
}
