import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/data/models/user.dart';
import 'package:registration_flutter/data/repository/pref/pref_repository.dart';
import 'package:registration_flutter/provider/auth/auth_state.dart';
import 'package:registration_flutter/utils/app_keys.dart';
import 'package:registration_flutter/utils/constants.dart';

class PrefNotifier extends StateNotifier<AuthState> {
  String get _tag {
    return runtimeType.toString();
  }

  final PrefRepository _repository;

  PrefNotifier(this._repository) : super(const AuthState.initial()) {
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    debugPrint('$_tag: checkLoggedIn ');
    try {
      final loggedIn = await _repository.getBoolean(PrefKeys.loginKey);
      debugPrint('$_tag: checkLoggedIn loggedIn $loggedIn');
      state = state.updateLoggedIn(loggedIn);
    } catch (e) {
      debugPrint('$_tag: checkLoggedIn e: $e');
      debugPrint(e.toString());
      state = state.updateLoggedIn(false);
    }
  }

  Future<bool> signUp(User user) async {
    try {
      return await _repository.setString(
          PrefKeys.registrationKey, jsonEncode(user.toJson()));
    } catch (e) {
      return false;
    }
  }

  Future<String> verifyLogin(String username, String password) async {
    try {
      final result = await _repository.getString(PrefKeys.registrationKey);
      debugPrint('$_tag: verifyLogin result: $result');
      if (result != null) {
        final Map<String, dynamic> maps = jsonDecode(result);
        debugPrint('$_tag: verifyLogin maps: $maps');
        final user = User.fromJson(maps);
        debugPrint('$_tag: verifyLogin user: $user');
        if (user.username == username && user.password == password) {
          await _repository.setBoolean(PrefKeys.loginKey, true);
          return "";
        }
      }
      return Constants.invalidCredentials;
    } catch (e) {
      return Constants.wentWrong;
    }
  }

  Future<void> logOut() async {
    try {
      await _repository.delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
