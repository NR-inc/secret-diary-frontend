import 'package:dio/dio.dart';
import 'package:sddata/network/grapqhql_query.dart';
import 'package:sddomain/core/error_handler.dart';

class NetworkExecutor {
  ErrorHandler _errorHandler;

  NetworkExecutor(this._errorHandler);

  Future<dynamic> makeRequest(Dio dio, GraphQlQuery query) async {
    Response response;
    try {
      response = await dio.post('', data: query.toJson());
      final data = response.data['data'];
      if (data == null) _errorHandler.handleError(response.data);
      return data;
    } on dynamic catch (ex) {
      _errorHandler.handleNetworkError(ex);
    }
  }
}
