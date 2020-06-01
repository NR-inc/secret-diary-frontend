import 'package:common_ui/ui_constants/locators.dart';
import 'package:flutter_driver/flutter_driver.dart';

abstract class BaseScreen {
  final FlutterDriver flutterDriver;
  final SerializableFinder screen;
  final SerializableFinder backButton = find.byValueKey(Locators.popLocator);

  BaseScreen(this.flutterDriver, this.screen);

  Future<bool> isReady({Duration timeout}) async => isDisplayed(
        finder: screen,
        timeout: timeout,
      );

  Future<void> tapBackButton() async => flutterDriver.tap(backButton);

  Future<bool> isDisplayed({
    SerializableFinder finder,
    String text,
    Duration timeout,
  }) async {
    timeout ??= const Duration(seconds: 2);
    try {
      if (text != null) {
        await flutterDriver.waitFor(find.text(text), timeout: timeout);
      } else {
        await flutterDriver.waitFor(finder, timeout: timeout);
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
