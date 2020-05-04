import 'package:flutter/material.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/exceptions/network_exception.dart';
import 'package:ssecretdiary/feature/widgets/alerts.dart';

abstract class BaseState<W extends StatefulWidget> extends State<W> {
  handleError(dynamic error,
      [Function(ValidationException) validationHandler]) {
    switch (error.runtimeType) {
      case NetworkException:
        showSimpleErrorDialog(context: context, title: 'Network error');
        break;
      case ValidationException:
        if (validationHandler == null) {
          showSimpleErrorDialog(
              context: context,
              description: (error as ValidationException).message);
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
