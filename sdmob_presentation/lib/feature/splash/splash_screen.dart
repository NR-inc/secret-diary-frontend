import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ssecretdiary/core/navigation/router.dart';
import 'package:sddomain/bloc/splash_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:common_ui/common_ui.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  static const _splashScreenDelayInSec = 5;
  final _splashBloc = Injector.getInjector().get<SplashBloc>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashBloc.sessionAvailabilitySubject
        .throttleTime(Duration(seconds: _splashScreenDelayInSec),
            trailing: true)
        .listen((bool hasSession) {
      if (hasSession) {
        Navigator.pushReplacementNamed(context, AppRoutes.root);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
    _splashBloc.checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: SdColors.primaryColor,
            child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment.center.add(
                    AlignmentDirectional(0, -0.1),
                  ),
                  child: Image.asset(
                    SdAssets.bookSplashImg,
                    package: commonUiPackage,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )),
              Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(SdAssets.appLogo,
                      package: commonUiPackage)),
              Align(
                  alignment: Alignment.center.add(
                    AlignmentDirectional(0, 0.5),
                  ),
                  child: getLoader())
            ])));
  }
}
