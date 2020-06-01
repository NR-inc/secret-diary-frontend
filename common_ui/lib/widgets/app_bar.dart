import 'package:common_ui/common_ui.dart';
import 'package:flutter/material.dart';

AppBar getAppBar({
  @required BuildContext context,
  @required String key,
  String title = SdStrings.empty,
  List<Widget> options,
  bool showBackButton = true,
}) =>
    AppBar(
      key: Key(key),
      title: Text(title),
      leading: Visibility(
        child: BackButton(key: Key(Locators.popLocator)),
        visible: showBackButton,
        maintainSize: showBackButton,
        maintainAnimation: showBackButton,
        maintainState: showBackButton,
      ),
    );
