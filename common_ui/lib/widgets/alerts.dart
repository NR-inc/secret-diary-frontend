import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSimpleErrorDialog(
    {BuildContext context,
    String title = 'Error has occurred',
    String description = 'Something went wrong.',
    String buttonName = 'OK'}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            new FlatButton(
              child: Text(buttonName, style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            new FlatButton(
              child: Text(buttonName),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    },
  );
}
