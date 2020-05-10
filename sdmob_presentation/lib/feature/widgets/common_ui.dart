import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget showLoader({@required bool show}) => Visibility(
    visible: show,
    child: AbsorbPointer(
      absorbing: false,
      child: Container(
        child: Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator(),
        ),
      ),
    ));

Widget getLoader() => Platform.isAndroid
    ? CircularProgressIndicator()
    : CupertinoActivityIndicator();
