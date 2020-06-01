import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget simpleButton({
  @required String key,
  @required String text,
  Function onPressed,
}) {
  if (Platform.isAndroid) {
    return MaterialButton(
      key: Key(key),
      child: Text(text),
      onPressed: onPressed,
    );
  } else {
    return CupertinoButton(
      key: Key(key),
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
