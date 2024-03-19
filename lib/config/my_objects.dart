import 'package:registration_flutter/models/pair.dart';

class MyObject {
  static MyObject? _singleton;

  MyObject._internal();

  static MyObject get instance {
    _singleton ??= MyObject._internal();
    return _singleton!;
  }

  late String _registrationUrl;

  late Triple<String, Triple<String, double?, double?>,
      Triple<String, double?, double?>> _splash;
  late String _appName;
  String _loginText = 'Login';
  String _signUpText = 'SignUp';

  late Pair<String, Triple<String, double?, double?>> _loginTopView;
  late Pair<String, Triple<String, double?, double?>> _signUpTopView;

  Pair<String, String> _switchToSignUp = Pair('Not registered ? ', 'SignUp');
  Pair<String, String> _switchToLogin =
      Pair('Already have an account ? ', 'Login');

  Triple<String, String, String> _usernameRegexMessage = Triple('Username',
      r'^[A-Za-z0-9_.]+$', 'Username have only alphabet and digits.');

  Triple<String, String, String> _passwordRegexMessage = Triple('Password',
      r'^[A-Za-z0-9_.]+$', 'Password have only alphabet and digits.');

  final Triple<String, String, String> _emailRegexMessage = Triple(
      'Email',
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      'Invalid Email.');

  void notRegisterSignUp(String notRegisteredText, signupText) {
    _switchToSignUp = Pair(notRegisteredText, signupText);
  }

  Pair<String, String> get switchToSignUp {
    return _switchToSignUp;
  }

  void alreadyRegistered(String alreadyRegisteredText, String loginText) {
    _switchToLogin = Pair(alreadyRegisteredText, loginText);
  }

  Pair<String, String> get switchToLogin {
    return _switchToLogin;
  }

  void setUsernameRegexMessage(String name, String regex, String message) {
    _usernameRegexMessage = Triple(name, regex, message);
  }

  Triple<String, String, String> get usernameValidation {
    return _usernameRegexMessage;
  }

  void setPasswordRegexMessage(String name, String regex, String message) {
    _passwordRegexMessage = Triple(name, regex, message);
  }

  Triple<String, String, String> get passwordValidation {
    return _passwordRegexMessage;
  }

  // void setEmailRegexMessage(String name, String regex, String message) {
  //   _emailRegexMessage = Triple(name, regex, message);
  // }
  //
  // Triple<String, String, String> get emailValidation {
  //   return _emailRegexMessage;
  // }

  get loginText {
    return _loginText;
  }

  get signUpText {
    return _signUpText;
  }

  void setLoginText(String loginText) {
    _loginText = loginText;
  }

  void setSignUpText(String signUpText) {
    _signUpText = signUpText;
  }

  void setRegistrationUrl(String url) {
    _registrationUrl = url;
  }

  String getRegistrationUrl() {
    return _registrationUrl;
  }

  void setSplash({
    required String name,
    String assetUrl = '',
    String imageUrl = '',
    double? height,
    double? width,
  }) {
    final asset = Triple<String, double?, double?>(assetUrl, height, width);
    final image = Triple<String, double?, double?>(imageUrl, height, width);
    _splash = Triple(name, asset, image);
  }

  Triple<String, Triple<String, double?, double?>,
      Triple<String, double?, double?>> getSplash() {
    return _splash;
  }

  void setAppName({required String name}) {
    _appName = name;
  }

  String getAppName() {
    return _appName;
  }

  void setLoginTopView(
      {String name = '', String image = '', double? height, double? width}) {
    _loginTopView = Pair(name, Triple(image, height, width));
  }

  Pair<String, Triple<String, double?, double?>> getLoginTopView() {
    return _loginTopView;
  }

  void setSignTopView(
      {String name = '', String image = '', double? height, double? width}) {
    _signUpTopView = Pair(name, Triple(image, height, width));
  }

  Pair<String, Triple<String, double?, double?>> getSignUpTopView() {
    return _signUpTopView;
  }
}
