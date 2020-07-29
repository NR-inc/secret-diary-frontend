import 'package:sd_base/src/configs/build_type.dart';

class NetworkConfigs {
  final String baseUrl;
  final int port;
  final int connectionTimeout;

  NetworkConfigs.init({
    this.baseUrl,
    this.port,
    this.connectionTimeout = 30000,
  });

  factory NetworkConfigs(BuildType buildType) {
    switch (buildType) {
      case BuildType.dev:
        return NetworkConfigs.init(
          baseUrl: 'https://secret-diary-api.herokuapp.com/',
        );
      case BuildType.prod:
        return NetworkConfigs.init(
          baseUrl: 'localhost',
          port: 8888,
        );
      case BuildType.mock:
        return NetworkConfigs.init(
          baseUrl: 'localhost',
          port: 8888,
        );
      default:
        throw Exception('Invalid build type: ${buildType.toString()}');
    }
  }
}
