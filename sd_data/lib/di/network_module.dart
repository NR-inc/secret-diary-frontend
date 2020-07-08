import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grpc/grpc.dart';
import 'package:proto_module/protos.dart';
import 'package:sdbase/di/abstract_module.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddata/network/network_executor.dart';
import 'package:sddomain/core/error_handler.dart';

class NetworkModule extends AbstractModule {
  static final NetworkModule _networkModule = NetworkModule._internal();
  static final _baseUrl = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  static const _port = 50051;
  static const _connectionTimeout = 3000;

  factory NetworkModule() {
    return _networkModule;
  }

  NetworkModule._internal();

  @override
  void configure(Injector injector) async {
    injector.map(
      (i) => ClientChannel(
        _baseUrl,
        port: _port,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          connectionTimeout: const Duration(microseconds: _connectionTimeout),
        ),
      ),
      isSingleton: true,
    );

    injector.map((i) => AuthClient(i.get()));

    injector.map((i) => NetworkExecutor(i.get()));
    injector.map((i) => ErrorHandler(), isSingleton: true);
    injector.map((i) => _getDioClient(), isSingleton: true);
  }

  Dio _getDioClient() {
    var dio = Dio(_getBaseDioOptions());
    return dio;
  }

  BaseOptions _getBaseDioOptions() =>
      BaseOptions(baseUrl: _baseUrl, connectTimeout: _connectionTimeout);
}
