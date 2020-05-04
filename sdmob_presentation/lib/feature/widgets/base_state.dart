import 'package:flutter/material.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/exceptions/network_exception.dart';
import 'package:ssecretdiary/feature/widgets/alerts.dart';

abstract class BaseState<W extends StatefulWidget> extends State<W> {
  void handleError(dynamic error,
      [Function(ValidationException) validationHandler]) {
    switch (error.runtimeType) {
      case NetworkException:
        final exception = error as NetworkException;
        showSimpleErrorDialog(
            context: context,
            title: 'Network error',
            description:
                exception.responseStatusType == ResponseStatusType.NO_NETWORK
                    ? 'No network connection'
                    : exception.message);
        break;
      case ValidationException:
        final exception = error as ValidationException;
        if (validationHandler == null) {
          showSimpleErrorDialog(
              context: context,
              title: 'Validation error',
              description: exception.message);
        } else {
          validationHandler(error);
        }
        break;
      default:
        showSimpleErrorDialog(context: context);
        break;
    }
  }
}
