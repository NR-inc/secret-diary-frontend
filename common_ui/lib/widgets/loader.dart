import 'dart:io';
import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget showLoader({
  @required bool show,
  Color background,
}) =>
    Visibility(
        visible: show,
        child: AbsorbPointer(
          absorbing: false,
          child: Container(
            color: background ?? Colors.transparent,
            child: Center(child: getLoader()),
          ),
        ));

Widget getLoader() {
  final key = Key(Locators.progressBarLocator);
  return Platform.isAndroid
      ? CircularProgressIndicator(key: key)
      : CupertinoActivityIndicator(key: key);
}
