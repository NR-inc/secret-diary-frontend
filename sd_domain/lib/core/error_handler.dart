import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Exception handleNetworkError(dynamic error) {
    print(error); // todo remove
    switch (error.runtimeType) {
      case FirebaseAuthException:
        final firebaseError = (error as FirebaseAuthException);
        return NetworkException(
          statusCode: int.tryParse(firebaseError?.code),
          message: firebaseError.message,
          description: firebaseError.code,
        );
        break;
      default:
        throw error;
        break;
    }
  }
}
