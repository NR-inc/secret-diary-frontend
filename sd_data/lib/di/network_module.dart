import 'package:dio/dio.dart';
import 'package:sdbase/di/abstract_module.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddata/network/network_executor.dart';
import 'package:sddomain/repository/config_repository.dart';
import 'package:sddomain/network/network_error_handler.dart';

class NetworkModule extends AbstractModule {
  static final NetworkModule _networkModule = NetworkModule._internal();
  static const _baseUrl = 'https://secret-diary-api.herokuapp.com/';
  static const _connectionTimeout = 1000;
  static const _authHeaderKey = 'Authorization';
  static const dioMainClientKey = 'main';
  static const dioAuthClientKey = 'auth';

  factory NetworkModule() {
    return _networkModule;
  }

  NetworkModule._internal();

  @override
  void configure(Injector injector) {
    injector.map((i) => NetworkExecutor(i.get()));
    injector.map((i) => NetworkErrorHandler(), isSingleton: true);
    injector.map((i) => _getAuthDioClient(),
        isSingleton: true, key: dioAuthClientKey);
    injectMainDioClient();
  }

  void injectMainDioClient() async {
    Injector injector = Injector.getInjector();
    final mainDioClient = await _getMainDioClient(injector.get());
    injector.map((i) => mainDioClient,
        isSingleton: true, key: dioMainClientKey);
  }

  Future<Dio> _getMainDioClient(ConfigRepository configRepository) async {
    final authToken = await configRepository.getAuthToken();
    final baseOptions = _getBaseDioOptions();
    if (authToken?.getToken() != null) {
      baseOptions.headers = {_authHeaderKey: 'Bearer ${authToken.getToken()}'};
    }
    var dio = Dio(baseOptions);
    _setInterceptor(dio);
    return dio;
  }

  Dio _getAuthDioClient() {
    var dio = Dio(_getBaseDioOptions());
    _setInterceptor(dio);
    return dio;
  }

  BaseOptions _getBaseDioOptions() =>
      BaseOptions(baseUrl: _baseUrl, connectTimeout: _connectionTimeout);

  void _setInterceptor(Dio dio) {
    final networkErrorHandler =
        Injector.getInjector().get<NetworkErrorHandler>();
    dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) => _requestInterceptor(options),
          onResponse: (Response response) => _responseInterceptor(response),
          onError: (DioError dioError) {
            _errorInterceptor(dioError);
            networkErrorHandler.errorWasFetched(dioError);
          }));
  }

  void _requestInterceptor(RequestOptions options) {
    print('\nRequest: '
        '\nheaders: \n${options.headers}'
        '\n${options.data}');
  }

  void _responseInterceptor(Response response) {
    print('\nResponse: '
        '\rstatus code: \n${response.statusCode}'
        '\nheaders: \n${response.headers}'
        '${response.data}');
  }

  void _errorInterceptor(DioError dioError) {
    print('\nNetwork error: \n${dioError.response.data}');
  }
}
