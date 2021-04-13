import 'package:common_ui/common_ui.dart';
import 'package:sddomain/export/models.dart';

class InvalidField {
  InvalidField(this.inputFieldType, this.error);

  InvalidField.empty()
      : inputFieldType = InputFieldType.none,
        error = SdStrings.empty;

  final InputFieldType inputFieldType;
  final String error;
}
