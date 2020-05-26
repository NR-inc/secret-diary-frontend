import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sddomain/export/domain.dart';

Widget inputField({
  @required Key inputFieldKey,
  @required Key errorFieldKey,
  @required TextEditingController controller,
  @required String hint,
  TextInputType keyboardType = TextInputType.text,
  textInputAction: TextInputAction.done,
  bool obscureText = false,
  bool showClearButton = false,
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
            suffixIcon: Visibility(
              visible: showClearButton,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: IconButton(
                icon: Icon(Icons.clear, size: Dimens.unit2),
                onPressed: () => controller.clear(),
              ),
            ),
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

Widget simpleButton({
  @required Key key,
  @required String text,
  Function onPressed,
}) {
  if (Platform.isAndroid) {
    return MaterialButton(
      key: key,
      child: Text(text),
      onPressed: onPressed,
    );
  } else {
    return CupertinoButton(
      key: key,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
