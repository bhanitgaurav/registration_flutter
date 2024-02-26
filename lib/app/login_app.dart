import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:registration_flutter/config/theme/app_theme.dart';
import 'package:registration_flutter/screens/splash_screen.dart';
import 'package:registration_flutter/utils/app_keys.dart';

class FlutterRiverpodLoginApp extends ConsumerWidget {
  const FlutterRiverpodLoginApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppKeys.appName,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
