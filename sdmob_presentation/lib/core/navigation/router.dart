import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/feature/feed/feed_screen.dart';
import 'package:ssecretdiary/feature/root/root_screen.dart';
import 'package:ssecretdiary/feature/splash/splash_screen.dart';

final router = {
  ScreensConstants.splashScreen: (BuildContext context) => SplashScreen(),
  ScreensConstants.rootScreen: (BuildContext context) => RootScreen(),
  ScreensConstants.feedScreen: (BuildContext context) => FeedScreen(),
}

class ScreensConstants {
  static const splashScreen = '/';
  static const rootScreen = '/root';
  static const loginScreen = '/login';
  static const registrationScreen = '/registration';
  static const feedScreen = '/feed';
  static const profileScreen = '/profile';
  static const postScreen = '/post';

}