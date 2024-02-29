import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:registration_flutter/config/my_objects.dart';
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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _username = '';
  var _password = '';

  var _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
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
      return;
    }
    _formKey.currentState!.save();

    if (_username.isEmpty || _password.isEmpty) {
      AppAlerts.displaySnackBar(context, Constants.usernamePasswordCantEmpty);
      return;
    }

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
      // clearTextFields(); // TODO: causes some Exception.
      AppAlerts.displaySnackBar(context, Constants.loggedInSuccessfully);
      context.navigator.pushReplacement(
          MyRoute.generateRoute(RouteLocation.dashboard, widget.screen));
    });
  }

  Widget _loadingSignUp() {
    if (_loading) {
      return const CircularProgressIndicator();
    } else {
      return DisplayWhiteText(
        text: MyObject.instance.loginText,
        fontWeight: FontWeight.w400,
      );
    }
  }

  Widget notRegistered() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(MyObject.instance.switchToSignUp.first),
        TextButton(
          onPressed: () {
            context.navigator.push(
                MyRoute.generateRoute(RouteLocation.signup, widget.screen));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: DisplayBlackText(
              text: MyObject.instance.switchToSignUp.second,
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

  void _formReset(
    GlobalKey<FormState> formKey,
    TextEditingController controllerChange,
    TextEditingController controller,
  ) {
    String stringValueOne = controllerChange.text;
    TextPosition textPositionOne = controllerChange.selection.base;

    String stringValueTwo = controller.text;
    TextPosition textPositionTwo = controller.selection.base;

    formKey.currentState!.reset();

    controllerChange.text = stringValueOne;
    controllerChange.selection = TextSelection.fromPosition(textPositionOne);

    controller.text = stringValueTwo;
    controller.selection = TextSelection.fromPosition(textPositionTwo);
  }

  loginViews() {
    final List<Widget> list = [];
    list.add(const Gap(20));
    list.add(
      CommonTextFormField(
        label: MyObject.instance.usernameValidation.first,
        controller: _userNameController,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            _formReset(_formKey, _userNameController, _passwordController);
          }
        },
        keyboardType: TextInputType.text,
        validator: (String? value) {
          if (value == null ||
              value.trim().isEmpty ||
              !RegExp(MyObject.instance.usernameValidation.second)
                  .hasMatch(value)) {
            return MyObject.instance.usernameValidation.third;
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
        label: MyObject.instance.passwordValidation.first,
        controller: _passwordController,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            _formReset(_formKey, _passwordController, _userNameController);
          }
        },
        keyboardType: TextInputType.visiblePassword,
        validator: (String? value) {
          if (value == null ||
              value.trim().isEmpty ||
              !RegExp(MyObject.instance.passwordValidation.second)
                  .hasMatch(value)) {
            return MyObject.instance.passwordValidation.third;
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
}
