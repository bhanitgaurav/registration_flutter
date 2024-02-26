import 'package:flutter/material.dart';
import 'package:registration_flutter/data/datasource/pref/pref_datasource.dart';

import 'pref_repository.dart';

class PrefRepositoryImpl implements PrefRepository {
  final PrefDatasource _prefSource;

  PrefRepositoryImpl(this._prefSource);

  String get _tag {
    return runtimeType.toString();
  }

  @override
  Future<bool> getBoolean(String key) async {
    try {
      return await _prefSource.getBoolean(key) ?? false;
    } catch (e) {
      debugPrint('$_tag: getBoolean : $e');
      return false;
    }
  }

  @override
  Future<int?> getInt(String key) async {
    try {
      return await _prefSource.getInt(key);
    } catch (e) {
      debugPrint('$_tag: getInt : $e');
      return null;
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return await _prefSource.getString(key);
    } catch (e) {
      debugPrint('$_tag: getString : $e');
      return null;
    }
  }

  @override
  Future<bool> setBoolean(String key, bool value) async {
    try {
      return await _prefSource.setBoolean(key, value);
    } catch (e) {
      debugPrint('$_tag: setBoolean : $e');
      return false;
    }
  }

  @override
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefSource.setInt(key, value);
    } catch (e) {
      debugPrint('$_tag: setInt : $e');
      return false;
    }
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefSource.setString(key, value);
    } catch (e) {
      debugPrint('$_tag: setString : $e');
      return false;
    }
  }

  @override
  Future<bool> clear(String username) async {
    try {
      return await _prefSource.clear(username);
    } catch (e) {
      debugPrint('$_tag: clear : $e');
      return false;
    }
  }

  @override
  Future<bool> delete() async {
    try {
      return await _prefSource.delete();
    } catch (e) {
      debugPrint('$_tag: delete : $e');
      return false;
    }
  }
}
