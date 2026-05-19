import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/constants/app_strings.dart';
import 'router.dart';

/// Root MaterialApp for CityWatch Canada.
///
/// Configures theming (light/dark with system default), routing, and title.
class CityWatchApp extends StatelessWidget {
  const CityWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
