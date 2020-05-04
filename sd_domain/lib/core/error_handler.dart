import 'package:dio/dio.dart';
import 'package:sddomain/exceptions/common_exception.dart';
import 'package:sddomain/exceptions/network_exception.dart';
import 'package:sddomain/exceptions/validation_exception.dart';

class ErrorHandler {
  void handleError(Map<String, dynamic> errorMap) {
    if (errorMap.containsKey('errors')) {
      final errors = errorMap['errors'] as List<dynamic>;
      // var validationErrorMap = Map<InputFieldType, String>();
      throw ValidationException(
          message: errors[0]['message'] ?? 'Validation error');
    }
    throw CommonException();
  }

  void handleNetworkError(dynamic error) {
    switch (error.runtimeType) {
      case DioError:
        final dioError = (error as DioError);
        throw NetworkException(
            statusCode: dioError?.response?.statusCode ?? -1,
            message: dioError.message);
        break;
      default:
        throw error;
        break;
    }
  }
}
