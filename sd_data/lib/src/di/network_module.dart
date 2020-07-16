import 'package:dio/dio.dart';
import 'package:sd_base/sd_base.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sd_data/src//network/network_executor.dart';
import 'package:sddomain/core/error_handler.dart';

class NetworkModule extends AbstractModule {
  static final NetworkModule _networkModule = NetworkModule._internal();

  factory NetworkModule() {
    return _networkModule;
  }

  NetworkModule._internal();

  @override
  void configure(Injector injector) async {
    injector.map((i) => NetworkExecutor(i.get()));
    injector.map((i) => ErrorHandler(), isSingleton: true);
    injector.map(
        (i) => _getDioClient(
              injector.get<AppConfigs>().networkConfigs,
            ),
        isSingleton: true);
  }

  Dio _getDioClient(NetworkConfigs networkConfigs) {
    var dio = Dio(_getBaseDioOptions(networkConfigs));
    _setInterceptor(dio);
    return dio;
  }

  BaseOptions _getBaseDioOptions(NetworkConfigs networkConfigs) => BaseOptions(
        baseUrl: networkConfigs.baseUrl,
        connectTimeout: networkConfigs.connectionTimeout,
      );

  void _setInterceptor(Dio dio) {
    dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) => _requestInterceptor(options),
          onResponse: (Response response) => _responseInterceptor(response),
          onError: (DioError dioError) => _errorInterceptor(dioError)));
  }

  void _requestInterceptor(RequestOptions options) {
    print('\nRequest: '
        '\nheaders: \n${options.headers}'
        '\n${options?.data}');
  }

  void _responseInterceptor(Response response) {
    print('\nResponse: '
        '\rstatus code: \n${response?.statusCode}'
        '\nheaders: \n${response?.headers}'
        '\n${response?.data}');
  }

  void _errorInterceptor(DioError dioError) {
    print('\nNetwork error: \n${dioError.response?.data}');
  }
}
