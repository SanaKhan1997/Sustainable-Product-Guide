import 'package:app/displays/home_screen.dart';
import 'package:app/displays/info_screen.dart';
import 'package:app/displays/product_display.dart';
import 'package:app/displays/user_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/displays/login_screen.dart';
import 'package:app/displays/sign_up_screen.dart';
import 'package:app/displays/startup_screen.dart';

import 'displays/image_screen.dart';
import 'displays/product_form_screen.dart';

class Routes {
  static const String StartupRoute = '/';
  static const String SignupRoute = '/signUp';
  static const String LoginRoute = '/logIn';
  static const String HomeRoute = '/home';
  static const String ProfileRoute = '/profile';
  static const String ProductRoute = '/product';
  static const String ProductPostRoute = '/productPost';
  static const String ImageRoute = '/image';
  static const String InfoRoute = '/info';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case ProfileRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case ProductRoute:
        return MaterialPageRoute(builder: (_) => ProductScreen());
      case ProductPostRoute:
        return MaterialPageRoute(builder: (_) => ProductFormScreen());
      case ImageRoute:
        return MaterialPageRoute(builder: (_) => ImageScreen());
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
