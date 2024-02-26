import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/route/my_routes.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/provider/pref/pref_provider.dart';
import 'package:registration_flutter/utils/extensions.dart';

class LogoutView extends ConsumerStatefulWidget {
  const LogoutView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogoutViewState();
}

class _LogoutViewState extends ConsumerState<LogoutView> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: logout,
      icon: const Icon(Icons.logout),
    );
  }

  void logout() {
    ref.read(prefProvider.notifier).logOut().then((value) {
      context.navigator
          .pushReplacement(MyRoute.generateRoute(RouteLocation.login));
    });
  }
}
