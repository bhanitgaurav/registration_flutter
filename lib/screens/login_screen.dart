import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/my_objects.dart';
import 'package:registration_flutter/screens/views/login_view.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/widgets/app_background.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';
import 'package:registration_flutter/widgets/loading_image.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen(this.screen, {super.key});

  final ConsumerWidget screen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    return Scaffold(
        body: Stack(
      children: [
        AppBackground(
          headerHeight: deviceSize.height * 0.3,
          header: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: topViews(),
            ),
          ),
        ),
        Positioned(
          top: (deviceSize.height * 0.3) - 40,
          left: 0,
          right: 0,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginView(screen),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  topViews() {
    final loginTopView = MyObject.instance.getLoginTopView();
    final List<Widget> list = [];
    if (loginTopView.first.isNotEmpty) {
      list.add(
        DisplayWhiteText(text: loginTopView.first, size: 40),
      );
    } else if (loginTopView.second.first.isNotEmpty) {
      list.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: LoadingImage(
          url: loginTopView.second.first,
          height: loginTopView.second.second,
          width: loginTopView.second.third,
        ),
      ));
    }
    return list;
  }
}
