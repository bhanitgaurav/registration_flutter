import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefDatasource {
  String get _tag {
    return runtimeType.toString();
  }

  static final PrefDatasource _instance = PrefDatasource._();

  factory PrefDatasource() => _instance;

  PrefDatasource._() {
    debugPrint('$_tag: PrefDatasource ');
    _initPref();
  }

  static SharedPreferences? _pref;

  Future<SharedPreferences> get pref async {
    debugPrint('$_tag: get ');
    _pref ??= await _initPref();
    return _pref!;
  }

  Future<SharedPreferences> _initPref() async {
    debugPrint('$_tag: _initPref ');
    var prefs = await SharedPreferences.getInstance();
    //     .then((value) {
    //   debugPrint('$_tag: _initPref success $value ');
    //   prefs = value;
    // }, onError: (error) {
    //   debugPrint('$_tag: _initPref error $error ');
    // });
    return prefs;
  }

  Future<bool> setString(String key, String value) async {
    debugPrint('$_tag: setString ');
    final prefs = await pref;
    return await prefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    debugPrint('$_tag: setInt ');
    final prefs = await pref;
    return await prefs.setInt(key, value);
  }

  Future<bool> setBoolean(String key, bool value) async {
    debugPrint('$_tag: setBoolean ');
    final prefs = await pref;
    return await prefs.setBool(key, value);
  }

  Future<String?> getString(String key) async {
    debugPrint('$_tag: getString ');
    final prefs = await pref;
    return prefs.getString(key);
  }

  Future<int?> getInt(String key) async {
    debugPrint('$_tag: getInt ');
    final prefs = await pref;
    return prefs.getInt(key);
  }

  Future<bool?> getBoolean(String key) async {
    debugPrint('$_tag: PrefBoolean ');
    final prefs = await pref;
    return prefs.getBool(key);
  }

  Future<bool> clear(String key) async {
    final prefs = await pref;
    return prefs.remove(key);
  }

  Future<bool> delete() async {
    final prefs = await pref;
    return prefs.clear();
  }
}
