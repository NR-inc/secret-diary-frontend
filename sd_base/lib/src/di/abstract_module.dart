import 'package:flutter_simple_dependency_injection/injector.dart';

abstract class AbstractModule {
  final Injector _injector;

  void configure(Injector injector);

  AbstractModule() : _injector = Injector();

  T get<T>({required String key, Map<String, dynamic>? additionalParameters}) {
    return this
        ._injector
        .get(key: key, additionalParameters: additionalParameters);
  }
}
