import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:registration_flutter/config/my_objects.dart';
import 'package:registration_flutter/config/route/my_routes.dart';
import 'package:registration_flutter/config/route/route_location.dart';
import 'package:registration_flutter/provider/api/api_provider.dart';
import 'package:registration_flutter/utils/app_alerts.dart';
import 'package:registration_flutter/utils/constants.dart';
import 'package:registration_flutter/utils/extensions.dart';
import 'package:registration_flutter/widgets/common_text_form_field.dart';
import 'package:registration_flutter/widgets/display_black_text.dart';
import 'package:registration_flutter/widgets/display_white_text.dart';

class InputOtpView extends ConsumerStatefulWidget {
  const InputOtpView(this.screen, {super.key});

  final ConsumerWidget screen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputOtpView();
}

class _InputOtpView extends ConsumerState<InputOtpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  var _otp = '';

  var _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
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

    if (_otp.isEmpty) {
      AppAlerts.displaySnackBar(context, Constants.usernamePasswordCantEmpty);
      return;
    }

    _showHideLoading(true);

    final result = await ref
        .read(apiProvider.notifier)
        .verifyOtp(_otp)
        .whenComplete(() => _showHideLoading(false));

    result.fold(
        (l) =>
            AppAlerts.displaySnackBar(context, Constants.errorInValidatingOtp),
        (r) {
      debugPrint('success : $r');
      context.navigator.pushReplacement(
        MyRoute.generateRoute(RouteLocation.dashboard, widget.screen),
      );
    });
  }

  Widget _loadingSignUp() {
    if (_loading) {
      return const CircularProgressIndicator();
    } else {
      return DisplayWhiteText(
        text: MyObject.instance.verifyOtpText,
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

  void _showHideLoading(bool show) {
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
  ) {
    String stringValueOne = controllerChange.text;
    TextPosition textPositionOne = controllerChange.selection.base;

    formKey.currentState!.reset();

    controllerChange.text = stringValueOne;
    controllerChange.selection = TextSelection.fromPosition(textPositionOne);
  }

  loginViews() {
    final List<Widget> list = [];
    list.add(const Gap(20));
    list.add(
      CommonTextFormField(
        label: MyObject.instance.otpValidation.first,
        controller: _otpController,
        maxLength: 6,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            _formReset(_formKey, _otpController);
          }
        },
        keyboardType: TextInputType.phone,
        validator: (String? value) {
          if (value == null ||
              value.trim().isEmpty ||
              !RegExp(MyObject.instance.otpValidation.second).hasMatch(value)) {
            return MyObject.instance.otpValidation.third;
          }
          return null;
        },
        onSaved: (String value) {
          _otp = value;
        },
      ),
    );
    list.add(const Gap(10));
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
    return list;
  }
}
