import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:registration_flutter/config/route/my_routes.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/provider/pref/pref_provider.dart';
import 'package:registration_flutter/utils/app_alerts.dart';
import 'package:registration_flutter/utils/constants.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/widgets/common_text_form_field.dart';
import 'package:registration_flutter/widgets/display_black_text.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';
import 'package:registration_flutter/widgets/password_text_from_field.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView(this.screen, {super.key});

  final ConsumerWidget screen;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _password = '';

  var _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: loginViews(),
      ),
    );
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('empty');
      return;
    }
    if (_username.isEmpty || _password.isEmpty) {
      AppAlerts.displaySnackBar(context, Constants.usernamePasswordCantEmpty);
      return;
    }
    _formKey.currentState!.save();

    showHideLoading(true);

    await ref
        .read(prefProvider.notifier)
        .verifyLogin(_username, _password)
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
    _formKey.currentState!.reset();
  }

  loginViews() {
    final List<Widget> list = [];
    list.add(
      CommonTextFormField(
        label: 'Username',
        onChanged: (String value) {
          if (value.isNotEmpty) {}
        },
        keyboardType: TextInputType.text,
        validator: (String? value) {
          if (value == null ||
              value.trim().isEmpty ||
              RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value)) {
            return 'Username have only alphabet and digits.';
          }
          return null;
        },
        onSaved: (String value) {
          _username = value;
        },
      ),
    );
    list.add(const Gap(10));
    list.add(
      PasswordTextFormField(
        label: 'Password',
        keyboardType: TextInputType.visiblePassword,
        validator: (String? value) {
          if (value == null ||
              value.trim().isEmpty ||
              RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value)) {
            return 'Password have only alphabet and digits.';
          }
          return null;
        },
        onSaved: (String value) {
          _password = value;
        },
      ),
    );
    list.add(const Gap(10));
    list.add(
      ElevatedButton(
        onPressed: _loading ? null : _login,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _loadingSignUp(),
        ),
      ),
    );
    list.add(const Gap(10));
    list.add(notRegistered());
    return list;
  }

  String? validateUserName(String? value) {
    if (value == null ||
        value.isEmpty ||
        int.tryParse(value) == null ||
        int.tryParse(value)! <= 0) {
      return 'Must be valid, positive number.';
    }
    return null;
  }
}
