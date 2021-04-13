import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget simpleButton({
  required Key key,
  required String text,
  TextStyle? style,
  required VoidCallback onPressed,
}) {
  if (Platform.isAndroid) {
    return MaterialButton(
      key: key,
      child: Text(
        text,
        style: style,
      ),
      onPressed: onPressed,
    );
  } else {
    return CupertinoButton(
      key: key,
      child: Text(
        text,
        style: style,
      ),
      onPressed: () => onPressed,
    );
  }
}
