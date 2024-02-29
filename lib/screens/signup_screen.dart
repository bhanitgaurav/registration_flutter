import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/my_objects.dart';
import 'package:registration_flutter/screens/views/signup_view.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/widgets/app_background.dart';
import 'package:registration_flutter/widgets/registration_top_view.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

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
              child: RegistrationTopView(
                registrationView: MyObject.instance.getSignUpTopView(),
              ),
            ),
        ),
        Positioned(
          top: (deviceSize.height * 0.3) - 40,
          left: 0,
          right: 0,
          child: const SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SignUpView(),
                ],
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}
