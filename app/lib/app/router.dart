import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:citywatch_canada/features/splash/splash_screen.dart';


/// App-level router configuration using GoRouter.
///
/// Stage 1 provides a minimal route table with a splash placeholder.
/// Subsequent stages will add auth screens, home, reports, etc.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
