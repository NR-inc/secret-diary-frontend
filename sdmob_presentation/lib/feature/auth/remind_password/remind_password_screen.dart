import 'package:common_ui/ui_constants/dimens.dart';
import 'package:common_ui/ui_constants/locators.dart';
import 'package:common_ui/ui_constants/sd_strings.dart';
import 'package:common_ui/widgets/app_bar.dart';
import 'package:common_ui/widgets/buttons.dart';
import 'package:common_ui/widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class RemindPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RemindPasswordState();
}

class RemindPasswordState extends BaseState<RemindPasswordScreen> {
  final emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        key: Locators.remindPasswordScreenLocator,
        title: SdStrings.remindPassword,
      ),
      body: _remindPasswordForm()
    );
  }

  Widget _remindPasswordForm() {
    return Container(
              padding: EdgeInsets.all(Dimens.unit2),
              child: Center(
                child: Column(children: <Widget>[
                  inputField(
                    inputFieldKey: Key(Locators.emailFieldLocator),
                    errorFieldKey: Key(Locators.emailErrorLocator),
                    controller: emailTextController,
                    hint: SdStrings.firstNameHint,
                    error: "Error",
                  ),
                  simpleButton(
                    key: Locators.remindPasswordButtonLocator,
                    text: SdStrings.remindPassword,
                    onPressed: _remindPasswordPressed,
                  )
                ]),
              ));
  }

    void _remindPasswordPressed() {
  }
}