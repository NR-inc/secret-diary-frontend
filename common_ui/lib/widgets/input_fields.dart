import 'package:common_ui/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget inputField({
  @required Key inputFieldKey,
  @required Key errorFieldKey,
  @required TextEditingController controller,
  @required String hint,
  TextInputType keyboardType = TextInputType.text,
  textInputAction: TextInputAction.done,
  bool obscureText = false,
  bool showClearButton = false,
  String error,
  String prefixIconAsset,
}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          key: inputFieldKey,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: SdColors.secondaryColor.withOpacity(0.5),
            ),
            prefixIcon: _getPrefixIcon(prefixIconAsset),
            prefix: SizedBox(
              width: Dimens.unit,
            ),
            suffixIcon: Visibility(
              visible: showClearButton,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: IconButton(
                icon: Icon(Icons.clear, size: Dimens.unit2),
                onPressed: () => controller.clear(),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimens.unit),
        Visibility(
          child: Text(
            error ?? SdStrings.empty,
            key: errorFieldKey,
            style: TextStyle(
              color: Colors.red,
              fontSize: Dimens.fontSize12,
            ),
          ),
          visible: error != null,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
        ),
      ],
    ),
  );
}

Widget _getPrefixIcon(String prefixIconAsset) {
  if (prefixIconAsset == null) {
    return null;
  }

  return Container(
    child: SvgPicture.asset(
      prefixIconAsset,
      package: commonUiPackage,
    ),
  );
}
