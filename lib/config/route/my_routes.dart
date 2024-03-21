import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/screens/input_otp_screen.dart';
import 'package:registration_flutter/screens/login_screen.dart';
import 'package:registration_flutter/screens/signup_otp_screen.dart';
import 'package:registration_flutter/screens/signup_screen.dart';
import 'package:registration_flutter/screens/splash_screen.dart';

class MyRoute {
  static MaterialPageRoute generateRoute(String route, ConsumerWidget screen) {
    if (route == RouteLocation.splash) {
      return MaterialPageRoute(builder: (_) => SplashScreen(screen));
    }
    if (route == RouteLocation.login) {
      return MaterialPageRoute(builder: (_) => LoginScreen(screen));
    }
    if (route == RouteLocation.signup) {
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    }
    if (route == RouteLocation.signupOtp) {
      return MaterialPageRoute(builder: (_) => SignUpOtpScreen(screen));
    }
    if (route == RouteLocation.inputOtp) {
      return MaterialPageRoute(builder: (_) => InputOtpScreen(screen));
    }
    if (route == RouteLocation.dashboard) {
      return MaterialPageRoute(builder: (_) => screen);
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
