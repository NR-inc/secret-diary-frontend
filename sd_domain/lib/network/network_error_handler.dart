import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';
import 'package:sddomain/model/validation_error_model.dart';
import 'package:sddomain/model/input_field_type.dart';

class NetworkErrorHandler {
  PublishSubject<DioError> networkError = PublishSubject();
  PublishSubject<List<ValidationErrorModel>> networkValidationError =
      PublishSubject();

  void handlerError(Map<dynamic, dynamic> responseWithoutData) {
    if (responseWithoutData.containsKey('errors')) {
      final errors = responseWithoutData['errors'] as List<dynamic>;
      var validationErrors = List<ValidationErrorModel>();
      errors.forEach((error) {
        validationErrors.add(ValidationErrorModel.fromJson(error)
          ..inputFieldType = InputFieldType.none);
      });
      validationErrorWasFetched(validationErrors);
      return;
    }
    errorWasFetched(DioError());
  }

  void errorWasFetched(DioError dioError) {
    networkError.add(dioError);
  }

  void validationErrorWasFetched(List<ValidationErrorModel> validationErrors) {
    networkValidationError.add(validationErrors);
  }
}
