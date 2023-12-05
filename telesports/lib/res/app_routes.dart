
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 

class AppRoutes {
  static const String splashScreen = 'splashScreen';
  static const String onBoardingScreen = 'onBoardingScreen';
  static const String welcomeScreen = 'welcomeScreen';
  static const String loginScreen = 'loginScreen';
  static const String landingPage = 'landingPage';

  static Map<String, Widget Function(BuildContext)> routes = {
    splashScreen: (context) =>   Container(),
    onBoardingScreen: (context) =>   Container(),
    
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) =>   Container(),
        );
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) =>   Container(),
        );
     
      default:
        return CupertinoPageRoute(
            builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
