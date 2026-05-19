import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../features/splash/splash_screen.dart';

/// Top‑level widget of CityWatch Canada.
/// It provides the ThemeData (light / dark) and the routing.
class CityWatchApp extends StatelessWidget {
  const CityWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CityWatch Canada',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    // TODO: Add additional routes for welcome, home, etc. in later stages.
  ],
);
