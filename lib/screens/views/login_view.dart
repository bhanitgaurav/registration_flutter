import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:registration_flutter/config/route/my_routes.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/provider/pref/pref_provider.dart';
import 'package:registration_flutter/utils/app_alerts.dart';
import 'package:registration_flutter/utils/constants.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/widgets/common_text_field.dart';
import 'package:registration_flutter/widgets/display_black_text.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView(this.screen, {super.key});

  final ConsumerWidget screen;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonTextField(
          hintText: 'Username',
          title: 'Username',
          controller: _usernameController,
        ),
        const Gap(10),
        CommonTextField(
          hintText: 'Password',
          title: 'Password',
          controller: _passwordController,
        ),
        const Gap(30),
        ElevatedButton(
          onPressed: _loading ? null : _login,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _loadingSignUp(),
          ),
        ),
        const Gap(10),
        notRegistered()
      ],
    );
  }

  void _login() async {
    final userName = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (userName.isEmpty || password.isEmpty) {
      AppAlerts.displaySnackBar(context, Constants.usernamePasswordCantEmpty);
      return;
    }
    showHideLoading(true);

    await ref
        .read(prefProvider.notifier)
        .verifyLogin(userName, password)
        .then((value) {
      showHideLoading(false);
      if (value.isNotEmpty) {
        AppAlerts.displaySnackBar(context, value);
        return;
      }
      clearTextFields();
      AppAlerts.displaySnackBar(context, Constants.loggedInSuccessfully);
      context.navigator.pushReplacement(
          MyRoute.generateRoute(RouteLocation.dashboard, widget.screen));
    });
  }

  Widget _loadingSignUp() {
    if (_loading) {
      return const CircularProgressIndicator();
    } else {
      return const DisplayWhiteText(
        text: 'Login',
        fontWeight: FontWeight.w400,
      );
    }
  }

  Widget notRegistered() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Not registered ? '),
        TextButton(
          onPressed: () {
            context.navigator.push(
                MyRoute.generateRoute(RouteLocation.signup, widget.screen));
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: DisplayBlackText(
              text: 'SignUp',
              fontWeight: FontWeight.bold,
              size: 14,
            ),
          ),
        )
      ],
    );
  }

  void showHideLoading(bool show) {
    setState(() {
      _loading = show;
    });
  }

  void clearTextFields() {
    _usernameController.clear();
    _passwordController.clear();
  }
}
