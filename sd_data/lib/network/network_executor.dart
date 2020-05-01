import 'package:dio/dio.dart';
import 'package:sddata/network/grapqhql_query.dart';
import 'package:sddomain/network/network_error_handler.dart';

class NetworkExecutor {
  NetworkErrorHandler _networkErrorHandler;

  NetworkExecutor(this._networkErrorHandler);

  Future<dynamic> makeRequest(Dio dio, GraphQlQuery query) async {
    Response response;
    try {
      response = await dio.post('', data: query.toJson());
      final data = response.data['data'];
      if (data == null) throw Object;
      return data;
    } on Object {
      _networkErrorHandler.handlerError(response.data);
    }
  }
}
