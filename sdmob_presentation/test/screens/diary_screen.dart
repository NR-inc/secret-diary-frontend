import 'package:common_ui/ui_constants/locators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'base_screen.dart';

class DiaryScreen extends BaseScreen {
  DiaryScreen(FlutterDriver flutterDriver)
      : super(
          flutterDriver,
          find.byValueKey(Locators.diaryScreenLocator),
        );
}
