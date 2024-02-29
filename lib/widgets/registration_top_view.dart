import 'package:flutter/material.dart';
import 'package:registration_flutter/models/pair.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';
import 'package:registration_flutter/widgets/loading_image.dart';

class RegistrationTopView extends StatelessWidget {
  const RegistrationTopView({required this.registrationView, super.key});

  final Pair<String, Triple<String, double?, double?>> registrationView;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: topViews(),
    );
  }

  topViews() {
    final List<Widget> list = [];
    if (registrationView.first.isNotEmpty) {
      list.add(
        DisplayWhiteText(text: registrationView.first, size: 40),
      );
    } else if (registrationView.second.first.isNotEmpty) {
      list.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: LoadingImage(
          url: registrationView.second.first,
          height: registrationView.second.second,
          width: registrationView.second.third,
        ),
      ));
    }
    return list;
  }
}
