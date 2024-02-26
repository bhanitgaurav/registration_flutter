import 'package:flutter/material.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/screens/dashboard_screen.dart';
import 'package:registration_flutter/screens/login_screen.dart';
import 'package:registration_flutter/screens/signup_screen.dart';
import 'package:registration_flutter/screens/splash_screen.dart';

class MyRoute {
  static MaterialPageRoute generateRoute(String route) {
    if (route == RouteLocation.splash) {
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
    if (route == RouteLocation.login) {
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
    if (route == RouteLocation.signup) {
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    }
    if (route == RouteLocation.dashboard) {
      return MaterialPageRoute(builder: (_) => const DashboardScreen());
    }
    return _errorRoute(route);
  }

  static MaterialPageRoute _errorRoute(String? route) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                  child: Text(
                'No route defined for $route',
              )),
            ));
  }
}
