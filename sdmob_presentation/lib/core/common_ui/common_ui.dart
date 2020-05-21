import 'package:flutter/material.dart';
import 'package:ssecretdiary/core/constants/dimens.dart';
import 'package:ssecretdiary/core/constants/sd_strings.dart';

Widget inputField({
  @required Key inputFieldKey,
  @required Key errorFieldKey,
  @required TextEditingController controller,
  @required String hint,
  TextInputType keyboardType,
  textInputAction: TextInputAction.done,
  bool obscureText = false,
  String error,
}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
        SizedBox(height: Dimens.unit),
        Visibility(
          child: Text(
            error ?? SdStrings.empty,
            style: TextStyle(
              color: Colors.red,
              fontSize: Dimens.fontSize12,
            ),
          ),
          visible: error != null,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
        ),
      ],
    ),
  );
}