import 'package:flutter/material.dart';
import 'package:registration_flutter/screens/splash_screen.dart';
import 'package:registration_flutter/utils/app_keys.dart';
import 'package:sample/dashboard_screen.dart';

import '../../config/theme/app_theme.dart';

class FlutterRiverpodLoginApp extends StatelessWidget {
  const FlutterRiverpodLoginApp({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      title: AppKeys.appName,
      theme: AppTheme.light,
      home: const SplashScreen(DashboardScreen()),
    );
  }
}
