import 'package:common_ui/common_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:sddomain/export/domain.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends BaseState<ChangePasswordScreen> {
  final _userBloc = Injector().get<UserBloc>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(
          context: context,
          key: Locators.registrationScreenLocator,
          title: SdStrings.registration,
        ),
        body: StreamBuilder(
            stream: _userBloc.loadingProgressStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                Stack(children: <Widget>[
                  _changePasswordForm(),
                  showLoader(show: snapshot.hasData && (snapshot.data)!)
                ])));
  }

  Widget _changePasswordForm() => StreamBuilder(
    stream: _userBloc.registrationResult,
    builder: (context, output) {
      Map<InputFieldType, String> validationErrors = output.hasError &&
          output.error?.runtimeType == ValidationException
          ? (output.error as ValidationException).validationErrors
          : {};
      return Container(
          padding: EdgeInsets.all(Dimens.unit2),
          child: Center(
            child: Column(children: <Widget>[
              inputField(
                inputFieldKey: Key(Locators.firstNameFieldLocator),
                errorFieldKey: Key(Locators.firstNameErrorLocator),
                controller: firstNameTextController,
                hint: SdStrings.firstNameHint,
                error: validationErrors[InputFieldType.firstName],
              ),
              inputField(
                inputFieldKey: Key(Locators.lastNameFieldLocator),
                errorFieldKey: Key(Locators.lastNameErrorLocator),
                controller: lastNameTextController,
                hint: SdStrings.lastNameHint,
                error: validationErrors[InputFieldType.lastName],
              ),
              inputField(
                inputFieldKey: Key(Locators.emailFieldLocator),
                errorFieldKey: Key(Locators.emailErrorLocator),
                controller: emailTextController,
                hint: SdStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                error: validationErrors[InputFieldType.email],
              ),
              inputField(
                inputFieldKey: Key(Locators.passwordFieldLocator),
                errorFieldKey: Key(Locators.passwordErrorLocator),
                controller: passwordTextController,
                hint: SdStrings.passwordHint,
                obscureText: true,
                error: validationErrors[InputFieldType.password],
              ),
              simpleButton(
                key: Key(Locators.registrationButtonLocator),
                text: SdStrings.registration,
                onPressed: _registrationPressed,
              )
            ]),
          ));
    },
  );
}
