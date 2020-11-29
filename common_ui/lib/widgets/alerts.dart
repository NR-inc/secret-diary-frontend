import 'dart:io';

import 'package:common_ui/common_ui.dart';
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

void show2OptionsDialog({
  @required BuildContext context,
  @required String title,
  @required String description,
  @required String option1ButtonName,
  Function option1ButtonCallback,
  TextStyle option1ButtonTextStyle =
      const TextStyle(color: SdColors.secondaryColor),
  @required String option2ButtonName,
  Function option2ButtonCallback,
  TextStyle option2ButtonTextStyle =
      const TextStyle(color: SdColors.secondaryColor),
}) {
  final actions = [
    FlatButton(
      child: Text(
        option1ButtonName,
        style: option1ButtonTextStyle,
      ),
      onPressed: option1ButtonCallback != null
          ? option1ButtonCallback
          : () => Navigator.of(context).pop(),
    ),
    FlatButton(
      child: Text(
        option2ButtonName,
        style: option2ButtonTextStyle,
      ),
      onPressed: option2ButtonCallback != null
          ? () => option2ButtonCallback
          : () => Navigator.of(context).pop(),
    ),
  ];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(description),
          actions: actions,
        );
      } else {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: actions,
        );
      }
    },
  );
}

void showPasswordRequiredDialog({
  @required BuildContext context,
  @required Function(String) submitCallback,
  @required TextEditingController passwordController,
  @required ValueNotifier<String> passwordErrorNotifier,
  @required ValueNotifier<bool> loadingProgress,
  TextStyle cancelButtonTextStyle =
      const TextStyle(color: SdColors.secondaryColor),
  TextStyle submitButtonTextStyle =
      const TextStyle(color: SdColors.secondaryColor),
}) {
  final actions = [
    FlatButton(
      child: Text(
        SdStrings.submitButton,
        style: submitButtonTextStyle,
      ),
      onPressed: () {
        submitCallback(passwordController.text);
      },
    ),
    FlatButton(
      child: Text(
        SdStrings.cancelButton,
        style: cancelButtonTextStyle,
      ),
      onPressed: () {
        passwordErrorNotifier.value = null;
        passwordController.text = SdStrings.empty;
        Navigator.of(context).pop();
      },
    ),
  ];

  final content = ValueListenableBuilder(
    valueListenable: loadingProgress,
    builder: (context, value, child) {
      return Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width - Dimens.unit4,
            child: Padding(
                padding: EdgeInsets.only(
                  top: Dimens.unit3,
                  bottom: Dimens.unit2,
                  left: Dimens.unit2,
                  right: Dimens.unit2,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      SdStrings.passwordRequiredTitleMsg,
                      style: TextStyle(
                        fontSize: Dimens.fontSize16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Dimens.unit2),
                    ValueListenableBuilder(
                        valueListenable: passwordErrorNotifier,
                        builder: (context, passwordError, widget) {
                          return inputField(
                            inputFieldKey: Key(Locators.passwordFieldLocator),
                            errorFieldKey: Key(Locators.passwordErrorLocator),
                            controller: passwordController,
                            error: passwordError,
                            hint: SdStrings.passwordHint,
                            obscureText: true,
                          );
                        }),
                    Row(
                      children: actions,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ],
                ))),
        Positioned.fill(
            child: showLoader(
          show: value,
          background: Colors.white.withOpacity(0.5),
        )),
      ]);
    },
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.unit),
        ),
        child: content,
      );
    },
  );
}
