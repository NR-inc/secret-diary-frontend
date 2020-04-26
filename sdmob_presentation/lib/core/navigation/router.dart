import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/feature/auth/login/login_screen.dart';
import 'package:ssecretdiary/feature/auth/registration/registration_screen.dart';
import 'package:ssecretdiary/feature/post/post_screen.dart';
import 'package:ssecretdiary/feature/root/root_screen.dart';
import 'package:ssecretdiary/feature/splash/splash_screen.dart';

class ApplicationRouter {
  Route call(RouteSettings settings) {
    Route route;
    switch (settings.name) {
      case AppRoutes.splash:
        route = MaterialPageRoute(builder: (context) => SplashScreen());
        break;
      case AppRoutes.login:
        route = MaterialPageRoute(builder: (context) => LoginScreen());
        break;
      case AppRoutes.registration:
        route = MaterialPageRoute(builder: (context) => RegistrationScreen());
        break;
      case AppRoutes.root:
        route = MaterialPageRoute(builder: (context) => RootScreen());
        break;
      case AppRoutes.feed:
        route = MaterialPageRoute(
            builder: (context) => RootScreen(startPageIndex: 0));
        break;
      case AppRoutes.profile:
        route = MaterialPageRoute(
            builder: (context) => RootScreen(startPageIndex: 1));
        break;
      case AppRoutes.post:
        route = MaterialPageRoute(builder: (context) => PostScreen());
        break;
    }
    return route;
  }
}

class AppRoutes {
  static const splash = '/';
  static const root = '/root';
  static const feed = '/root/feed';
  static const profile = '/root/profile';
  static const login = '/login';
  static const registration = '/registration';
  static const post = '/post';
}
