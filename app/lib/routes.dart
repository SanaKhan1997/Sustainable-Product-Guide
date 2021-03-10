import 'package:app/displays/home_screen.dart';
import 'package:app/displays/info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/displays/login_screen.dart';
import 'package:app/displays/sign_up_screen.dart';
import 'package:app/displays/startup_screen.dart';

class Routes {
  static const String StartupRoute = '/';
  static const String SignupRoute = '/signUp';
  static const String LoginRoute = '/logIn';
  static const String HomeRoute = '/home';
  static const String InfoRoute = '/info';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case InfoRoute:
        return MaterialPageRoute(builder: (_) => InfoScreen());
      case StartupRoute:
        return MaterialPageRoute(builder: (_) => StartupScreen());
      case SignupRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case LoginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
