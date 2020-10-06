import 'dart:ui';

import 'package:common_ui/common_ui.dart';
import 'package:flutter/widgets.dart';

Widget divider({Color color}) => Container(
      width: double.infinity,
      height: 1,
      color: color ?? SdColors.greyColor,
    );
