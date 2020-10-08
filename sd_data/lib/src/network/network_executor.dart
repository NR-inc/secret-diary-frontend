import 'package:sddomain/core/error_handler.dart';

class NetworkExecutor {
  ErrorHandler _errorHandler;

  NetworkExecutor(this._errorHandler);

  Future<dynamic> makeRequest(Function transaction) async {
    try {
      transaction.call();
    } on dynamic catch (ex) {
      throw _errorHandler.handleNetworkError(ex);
    }
  }
}
