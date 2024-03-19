import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:registration_flutter/config/my_objects.dart';
import 'package:registration_flutter/data/models/user.dart';
import 'package:registration_flutter/provider/api/api_provider.dart';
import 'package:registration_flutter/provider/date_provider.dart';
import 'package:registration_flutter/provider/time_provider.dart';
import 'package:registration_flutter/utils/app_alerts.dart';
import 'package:registration_flutter/utils/constants.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/utils/helpers.dart';
import 'package:registration_flutter/widgets/common_text_form_field.dart';
import 'package:registration_flutter/widgets/display_black_text.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';
import 'package:registration_flutter/widgets/password_text_from_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
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
    _usernameController.dispose();
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

  loginViews() {
    final List<Widget> list = [];
    list.add(const Gap(20));
    list.add(
      CommonTextFormField(
        label: MyObject.instance.usernameValidation.first,
        controller: _usernameController,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            _formReset(_formKey, _usernameController, _passwordController);
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
            _formReset(_formKey, _passwordController, _usernameController);
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
        onPressed: _loading ? null : _signUp,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _loadingSignUp(),
        ),
      ),
    );
    list.add(const Gap(10));
    list.add(_alreadyHaveAnAccount());
    return list;
  }

  void _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (_username.isEmpty || _password.isEmpty) {
      AppAlerts.displaySnackBar(context, Constants.usernamePasswordCantEmpty);
      return;
    }

    _showHideLoading(true);

    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);

    final user = User(
      username: _username.trim(),
      password: _password.trim(),
      time: Helpers.timeToString(time),
      date: DateFormat.yMMMd().format(date),
    );

    // await ref.read(prefProvider.notifier).signUp(user).then((value) {
    //   _showHideLoading(false);
    //   if (!value) {
    //     AppAlerts.displaySnackBar(context, Constants.errorInSignUp);
    //     return;
    //   }
    //   clearTextFields();
    //   AppAlerts.displaySnackBar(context, Constants.signUpSuccessfully);
    //   context.navigator.pop();
    // });

    final result = await ref
        .read(apiProvider.notifier)
        .fetchJokesApiRequest(user)
        .whenComplete(() => _showHideLoading(false));

    result.fold(
        (l) => AppAlerts.displaySnackBar(context, Constants.errorInSignUp),
        (r) {
      debugPrint('success : $r');
      clearTextFields();
      AppAlerts.displaySnackBar(context, Constants.signUpSuccessfully);
      context.navigator.pop();
    });
  }

  Widget _loadingSignUp() {
    if (_loading) {
      return const CircularProgressIndicator();
    } else {
      return DisplayWhiteText(
        text: MyObject.instance.signUpText,
        fontWeight: FontWeight.w400,
      );
    }
  }

  Widget _alreadyHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(MyObject.instance.switchToLogin.first),
        TextButton(
          onPressed: () {
            context.navigator.pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: DisplayBlackText(
              text: MyObject.instance.switchToLogin.second,
              fontWeight: FontWeight.bold,
              size: 14,
            ),
          ),
        )
      ],
    );
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

  void _showHideLoading(bool show) {
    setState(() {
      _loading = show;
    });
  }

  void clearTextFields() {
    _usernameController.clear();
    _passwordController.clear();
  }
}
