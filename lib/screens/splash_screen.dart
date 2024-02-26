import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/route/my_routes.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/provider/pref/pref_provider.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/widgets/app_background.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';

class SplashScreen extends ConsumerWidget {
  String get _tag {
    return runtimeType.toString();
  }

  const SplashScreen(this.dashboardScreen, {super.key});

  final ConsumerWidget dashboardScreen;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    // final loggedIn = ref.watch(authProvider);
    final loggedIn = ref.watch(prefProvider);

    _watchLoggedIn(loggedIn.loggedIn, context);
    return AppBackground(
      headerHeight: deviceSize.height,
      header: const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DisplayWhiteText(text: 'Splash', size: 40),
          ],
        ),
      ),
    );
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
        context.navigator.pushReplacement(
            MyRoute.generateRoute(RouteLocation.login, dashboardScreen));
      });
    }
  }
}
