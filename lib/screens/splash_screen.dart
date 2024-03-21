import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/my_objects.dart';
import 'package:registration_flutter/config/route/my_routes.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/models/pair.dart';
import 'package:registration_flutter/provider/pref/pref_provider.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/widgets/app_background.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';

import '../widgets/loading_image.dart';

class SplashScreen extends ConsumerWidget {
  String get _tag {
    return runtimeType.toString();
  }

  const SplashScreen(this.dashboardScreen, {super.key});

  final ConsumerWidget dashboardScreen;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final loggedIn = ref.watch(prefProvider);
    _watchLoggedIn(loggedIn.loggedIn, context);

    return AppBackground(
      headerHeight: deviceSize.height,
      header: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: splashViews(),
        ),
      ),
    );
  }

  List<Widget> splashViews() {
    final List<Widget> list = [];
    final Triple<String, Triple<String, double?, double?>,
            Triple<String, double?, double?>> splash =
        MyObject.instance.getSplash();
    if (splash.first.isNotEmpty) {
      list.add(
        DisplayWhiteText(text: splash.first, size: 40),
      );
    }
    if (splash.second.first.isNotEmpty) {
      list.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Image.asset(
            splash.second.first,
            height: splash.second.second,
            width: splash.second.third,
          )));
    } else if (splash.third.first.isNotEmpty) {
      list.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LoadingImage(
            url: splash.third.first,
            height: splash.third.second,
            width: splash.third.third,
          )));
    }
    return list;
  }

  void _watchLoggedIn(bool? loggedIn, BuildContext context) {
    debugPrint('$_tag:watchLoggedIn : before 2 seconds : $loggedIn');
    if (loggedIn == null) {
      return;
    }
    if (loggedIn) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        context.navigator.pushReplacement(
            MaterialPageRoute(builder: (builder) => dashboardScreen));
      });
    } else {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        final String route;
        if (MyObject.instance.signInUsingOtp) {
          route = RouteLocation.signupOtp;
        } else {
          route = RouteLocation.login;
        }
        context.navigator.pushReplacement(MyRoute.generateRoute(route, dashboardScreen));
      });
    }
  }
}
