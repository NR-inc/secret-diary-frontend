import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ssecretdiary/feature/auth/login/login_screen.dart';
import 'package:ssecretdiary/feature/auth/registration/registration_screen.dart';
import 'package:ssecretdiary/feature/auth/remind_password/remind_password_screen.dart';
import 'package:ssecretdiary/feature/edit_profile/change_password_screen.dart';
import 'package:ssecretdiary/feature/edit_profile/edit_profile_screen.dart';
import 'package:ssecretdiary/feature/post/post_details_screen.dart';
import 'package:ssecretdiary/feature/post/post_screen.dart';
import 'package:ssecretdiary/feature/root/root_screen.dart';
import 'package:ssecretdiary/feature/splash/splash_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ApplicationRouter {
  Route? call(RouteSettings settings) {
    Route? route;
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
      case AppRoutes.remindPassword:
        route = MaterialPageRoute(builder: (context) => RemindPasswordScreen());
        break;
      case AppRoutes.root:
        route = MaterialPageRoute(builder: (context) => RootScreen());
        break;
      case AppRoutes.diary:
        route = MaterialPageRoute(
            builder: (context) => RootScreen(startPageIndex: 0));
        break;
      case AppRoutes.feed:
        route = MaterialPageRoute(
            builder: (context) => RootScreen(startPageIndex: 1));
        break;
      case AppRoutes.settings:
        route = MaterialPageRoute(
            builder: (context) => RootScreen(startPageIndex: 2));
        break;
      case AppRoutes.post:
        route = MaterialPageRoute(builder: (context) => PostScreen());
        break;
      case AppRoutes.editProfile:
        route = MaterialPageRoute(builder: (context) => EditProfileScreen());
        break;
      case AppRoutes.changePassword:
        route = MaterialPageRoute(builder: (context) => ChangePasswordScreen());
        break;
      case AppRoutes.postDetails:
        route = MaterialPageRoute(
          builder: (context) => PostDetailsScreen(
            postId: settings.arguments as String,
          ),
        );
        break;
    }
    return route;
  }
}

class AppRoutes {
  static const splash = '/';
  static const root = '/root';
  static const feed = '/root/feed';
  static const diary = '/root/diary';
  static const settings = '/root/settings';
  static const login = '/login';
  static const registration = '/registration';
  static const remindPassword = '/password';
  static const post = '/post';
  static const postDetails = '/postDetails';
  static const editProfile = '/root/diary/editProfile';
  static const changePassword = '/root/diary/editProfile/changePassword';
}
