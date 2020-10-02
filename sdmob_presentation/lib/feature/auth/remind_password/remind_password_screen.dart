import 'package:common_ui/common_ui.dart';
import 'package:common_ui/ui_constants/dimens.dart';
import 'package:common_ui/ui_constants/locators.dart';
import 'package:common_ui/ui_constants/sd_strings.dart';
import 'package:common_ui/widgets/app_bar.dart';
import 'package:common_ui/widgets/buttons.dart';
import 'package:common_ui/widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/bloc/remind_password_bloc.dart';
import 'package:sddomain/exceptions/validation_exception.dart';
import 'package:sddomain/export/domain.dart';
import 'package:sddomain/model/input_field_type.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class RemindPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RemindPasswordState();
}

class RemindPasswordState extends BaseState<RemindPasswordScreen> {
  final RemindPasswordBloc _remindPasswordBloc =
      Injector.getInjector().get<RemindPasswordBloc>();
  final emailTextController = TextEditingController();

  @override
  void initState() {
    _remindPasswordBloc.errorStream.listen((_) {}, onError: (ex) {
      if (ex is NetworkException && ex.description == 'user-not-found') {
        showToast(message: SdStrings.resetPasswordSuccessMessage);
      } else {
        handleError(ex);
      }
    });
    _remindPasswordBloc.remindPasswordResult.listen((result) {
      if (result == DefaultResponse.SUCCESS) {
        showToast(message: SdStrings.resetPasswordSuccessMessage);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _remindPasswordBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        key: Locators.remindPasswordScreenLocator,
        title: SdStrings.remindPassword,
      ),
      body: StreamBuilder(
          stream: _remindPasswordBloc.loadingProgressStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Stack(children: <Widget>[
              _remindPasswordForm(),
              showLoader(show: snapshot.hasData && snapshot.data)
            ]);
          }),
    );
  }

  Widget _remindPasswordForm() => StreamBuilder(
        stream: _remindPasswordBloc.remindPasswordResult,
        builder: (context, snapshot) {
          Map<InputFieldType, String> validationErrors = snapshot.hasError &&
                  snapshot.error?.runtimeType == ValidationException
              ? (snapshot.error as ValidationException).validationErrors
              : {};
          return Container(
              padding: EdgeInsets.all(Dimens.unit2),
              child: Center(
                child: Column(children: <Widget>[
                  inputField(
                      inputFieldKey: const Key(Locators.emailFieldLocator),
                      errorFieldKey: const Key(Locators.emailErrorLocator),
                      controller: emailTextController,
                      hint: SdStrings.emailHint,
                      error: validationErrors[InputFieldType.email],
                      prefixIconAsset: SdAssets.emailIcon),
                  simpleButton(
                    key: const Key(Locators.remindPasswordButtonLocator),
                    text: SdStrings.sendPasswordResetLinkButton,
                    onPressed: _remindPasswordPressed,
                  )
                ]),
              ));
        },
      );

  void _remindPasswordPressed() {
    _remindPasswordBloc.remindPassword(emailTextController.text);
  }
}
