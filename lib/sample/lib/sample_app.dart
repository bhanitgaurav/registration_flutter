import 'package:flutter/material.dart';
import 'package:registration_flutter/screens/splash_screen.dart';
import 'package:registration_flutter/utils/app_keys.dart';
import 'package:sample/dashboard_screen.dart';

import '../../config/my_objects.dart';
import '../../config/theme/app_theme.dart';

class FlutterRiverpodLoginApp extends StatelessWidget {
  const FlutterRiverpodLoginApp({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    final MyObject myObject = MyObject.instance;
    myObject.setSplashName('Splash');
    myObject.setBrandImage(
        'https://res.cloudinary.com/daedgnllx/image/upload/v1600763511/athancare_website_assets/home/logos/Athansys_logo_cvavsr.png');
    return MaterialApp(
      title: AppKeys.appName,
      theme: AppTheme.light,
      home: const SplashScreen(DashboardScreen()),
    );
  }
}
