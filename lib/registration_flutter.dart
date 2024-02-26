import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class EnsureInitialized {
  static ensureInitialization() {
    WidgetsFlutterBinding.ensureInitialized();
  }
}