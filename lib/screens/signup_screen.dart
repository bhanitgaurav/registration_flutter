import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/my_objects.dart';
import 'package:registration_flutter/provider/date_provider.dart';
import 'package:registration_flutter/screens/views/signup_view.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/utils/helpers.dart';
import 'package:registration_flutter/widgets/app_background.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';
import 'package:registration_flutter/widgets/loading_image.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final date = ref.watch(dateProvider);

    return Scaffold(
        body: Stack(
      children: [
        AppBackground(
          headerHeight: deviceSize.height * 0.3,
          header: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => {Helpers.selectDate(context, ref)},
                  child: /*DisplayWhiteText(
                    text: Helpers.dateFormatter(date),
                    fontWeight: FontWeight.normal,
                  )*/
                      Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: LoadingImage(url: MyObject.instance.getBrandImage()),
                  ),
                ),
                const DisplayWhiteText(text: 'Flutter Signup', size: 40),
              ],
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
    ));
  }
}
