import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppKeys {
  const AppKeys._();

  static const String isDarkMode = 'isDarkMode';
  static const String userTable = 'user';
  static const String appName = 'Flutter Login';
}

@immutable
class PrefKeys {
  const PrefKeys._();

  static const String loginKey = 'loginKey';
  static const String registrationKey = 'registrationKey';

  static const String userTable = 'user';
  static const String appName = 'Flutter Login';
}
