import 'dart:io';

import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sd_base/sd_base.dart';
import 'package:sddomain/bloc/user_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:sddomain/exceptions/network_exception.dart';
import 'package:sddomain/export/domain.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:ssecretdiary/feature/widgets/base_state.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends BaseState<EditProfileScreen> {
  final _userBloc = Injector().get<UserBloc>();

  UserModel _currentUser = UserModel.empty();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordErrorNotifier = ValueNotifier<String?>(null);
  final _passwordRequiredLoadingProgress = ValueNotifier<bool>(false);
  final _dataUpdatedNotifier = ValueNotifier<bool>(false);
  final _avatarNotifier = ValueNotifier<File?>(null);
  bool _cleanAvatar = false;
  final _imagePicker = ImagePicker();
  bool _isPasswordRequired = false;

  @override
  void initState() {
    _userBloc.profile();
    _userBloc.currentUserStream.listen((currentUser) {
      _currentUser = currentUser;
      _firstNameController.text = currentUser.firstName;
      _lastNameController.text = currentUser.lastName;
      _emailController.text = currentUser.email;

      _firstNameController.addListener(_dataChanged);
      _lastNameController.addListener(_dataChanged);
      _emailController.addListener(_dataChanged);
      _passwordController.addListener(_dataChanged);
    });
    _userBloc.loadingProgressStream.listen(
      (value) => _passwordRequiredLoadingProgress.value = value,
    );
    _userBloc.passwordRequiredResult.listen((isPasswordRequired) {
      _isPasswordRequired = isPasswordRequired;
      showPasswordRequiredDialog(
          context: context,
          passwordController: _passwordController,
          passwordErrorNotifier: _passwordErrorNotifier,
          loadingProgress: _passwordRequiredLoadingProgress,
          submitCallback: (password) {
            _updateProfileAction(
              password: password,
            );
          });
    });
    _userBloc.errorStream.listen((_) {}, onError: (ex) {
      _passwordRequiredLoadingProgress.value = false;
      if (ex is NetworkException &&
          ex.description == FirestoreKeys.wrongPasswordError) {
        _passwordErrorNotifier.value = SdStrings.fieldErrorWrongPassword;
      } else if (ex is ValidationException &&
          ex.validationErrors.containsKey(InputFieldType.password)) {
        _passwordErrorNotifier.value =
            ex.validationErrors[InputFieldType.password];
      } else {
        handleError(ex);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key(Locators.diaryScreenLocator),
        appBar: AppBar(
            title: Text('Edit profile'),
            centerTitle: true,
            actions: <Widget>[
              ValueListenableBuilder(
                  valueListenable: _dataUpdatedNotifier,
                  builder: (BuildContext context, bool dataChanged, c) {
                    return IconButton(
                      disabledColor: Colors.grey,
                      icon: Icon(Icons.check, color: Colors.white),
                      onPressed:
                          dataChanged ? () => _updateProfileAction() : null,
                    );
                  }),
            ]),
        body: StreamBuilder<bool>(
          stream: _userBloc.loadingProgressStream,
          initialData: true,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return Stack(children: <Widget>[
              _content,
              showLoader(show: (snapshot.data)!),
            ]);
          },
        ));
  }

  Widget get _content => StreamBuilder<bool>(
      stream: _userBloc.editProfileResultStream,
      initialData: true,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        Map<InputFieldType, String> validationErrors = snapshot.hasError &&
                snapshot.error?.runtimeType == ValidationException
            ? (snapshot.error as ValidationException).validationErrors
            : {};
        return Center(
            child: Column(children: <Widget>[
          SizedBox(height: 24),
          GestureDetector(
            child: _avatarWidget(),
            onTap: () async {
              final pickedFile =
                  await _imagePicker.getImage(source: ImageSource.camera);
              _avatarNotifier.value = File(pickedFile!.path);
              _cleanAvatar = false;
            },
            onLongPress: () {
              if (_cleanAvatar) {
                return;
              }
              _cleanAvatar = true;
              if (_avatarNotifier.value == null) {
                setState(() {});
              } else {
                _avatarNotifier.value = null;
              }
            },
          ),
          SizedBox(height: 24),
          inputField(
            errorFieldKey: Key(Locators.firstNameErrorLocator),
            controller: _firstNameController,
            hint: SdStrings.firstNameHint,
            error: validationErrors[InputFieldType.firstName],
          ),
          SizedBox(height: 8),
          inputField(
            errorFieldKey: Key(Locators.lastNameErrorLocator),
            controller: _lastNameController,
            hint: SdStrings.firstNameHint,
            error: validationErrors[InputFieldType.lastName],
          ),
          SizedBox(height: 8),
          inputField(
            errorFieldKey: Key(Locators.emailErrorLocator),
            controller: _emailController,
            hint: SdStrings.firstNameHint,
            error: validationErrors[InputFieldType.email],
          ),
          SizedBox(height: Dimens.unit2),
          TextButton(
            onPressed: () {
              _resetPasswordAction();
            },
            child: Text(
              SdStrings.resetMyPasswordMsg,
              style: TextStyle(
                fontSize: Dimens.fontSize16,
                fontWeight: FontWeight.bold,
                color: SdColors.secondaryColor,
              ),
            ),
          ),
          SizedBox(height: 24)
        ]));
      });

  Widget _avatarWidget() {
    return ValueListenableBuilder(
        valueListenable: _avatarNotifier,
        builder: (context, File? avatarFile, widget) {
          if (_cleanAvatar) {
            return Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: Dimens.avatarRadius * 2,
            );
          } else if (avatarFile != null) {
            return CircleAvatar(
              radius: Dimens.avatarRadius,
              backgroundImage: FileImage(avatarFile),
            );
          } else if (_currentUser.avatar.isNotEmpty) {
            return CircleAvatar(
              radius: Dimens.avatarRadius,
              backgroundImage: NetworkImage(_currentUser.avatar),
            );
          } else {
            return Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: Dimens.avatarRadius * 2,
            );
          }
        });
  }

  void _resetPasswordAction() {
    Navigator.pushNamed(
      context,
      AppRoutes.remindPassword,
    );
  }

  void _dataChanged() {
    if (_currentUser.firstName != _firstNameController.text ||
        _currentUser.lastName != _lastNameController.text ||
        _currentUser.email != _emailController.text ||
        _cleanAvatar == true ||
        _avatarNotifier.value != null) {
      _dataUpdatedNotifier.value = true;
    } else {
      _dataUpdatedNotifier.value = false;
    }
  }

  Future<void> _updateProfileAction({
    String? password,
  }) async {
    if (!_dataUpdatedNotifier.value) {
      return;
    }
    final result = await _userBloc.updateProfile(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: password,
      avatar: _avatarNotifier.value,
      cleanAvatar: _cleanAvatar,
    );
    if (result == true) {
      showToast(message: SdStrings.userPostUpdateSuccessMsg);
      Future.delayed(Duration(seconds: 1)).then(
        (value) {
          if (_isPasswordRequired) {
            Navigator.pop(context);
          }
          Navigator.pop(context);
        },
      );
    }
  }
}
