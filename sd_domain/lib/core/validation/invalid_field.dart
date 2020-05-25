import 'package:sddomain/model/input_field_type.dart';

class InvalidField {
  InvalidField(this.inputFieldType, this.error);

  final InputFieldType inputFieldType;
  final String error;
}
