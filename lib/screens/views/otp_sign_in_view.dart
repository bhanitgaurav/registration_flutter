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

class OtpSignInView extends ConsumerStatefulWidget {
  const OtpSignInView(this.screen, {super.key});

  final ConsumerWidget screen;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpSignInView();
}

class _OtpSignInView extends ConsumerState<OtpSignInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNumberController = TextEditingController();

  var _mobileNumber = '';

  var _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
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

    if (_mobileNumber.isEmpty) {
      AppAlerts.displaySnackBar(context, Constants.usernamePasswordCantEmpty);
      return;
    }

    _showHideLoading(true);

    final result = await ref
        .read(apiProvider.notifier)
        .generateOtp(_mobileNumber)
        .whenComplete(() => _showHideLoading(false));

    result.fold(
        (l) =>
            AppAlerts.displaySnackBar(context, Constants.errorInGeneratingOtp),
        (r) {
      debugPrint('success : $r');
      context.navigator.push(
        MyRoute.generateRoute(RouteLocation.inputOtp, widget.screen),
      );
    });
  }

  Widget _loadingSignUp() {
    if (_loading) {
      return const CircularProgressIndicator();
    } else {
      return DisplayWhiteText(
        text: MyObject.instance.generateOtpText,
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
        label: MyObject.instance.mobileValidation.first,
        controller: _mobileNumberController,
        maxLength: 10,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            _formReset(_formKey, _mobileNumberController);
          }
        },
        keyboardType: TextInputType.phone,
        validator: (String? value) {
          if (value == null ||
              value.trim().isEmpty ||
              !RegExp(MyObject.instance.mobileValidation.second)
                  .hasMatch(value)) {
            return MyObject.instance.mobileValidation.third;
          }
          return null;
        },
        onSaved: (String value) {
          _mobileNumber = value;
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
