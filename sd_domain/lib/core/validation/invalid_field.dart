import 'package:sddomain/export/models.dart';

class InvalidField {
  InvalidField(this.inputFieldType, this.error);

  final InputFieldType inputFieldType;
  final String error;
}
