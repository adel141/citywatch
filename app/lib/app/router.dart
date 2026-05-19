import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:citywatch_canada/features/splash/splash_screen.dart';
import 'package:citywatch_canada/features/auth/welcome_screen.dart';
import 'package:citywatch_canada/features/auth/login_screen.dart';
import 'package:citywatch_canada/features/auth/register_screen.dart';

/// App-level router configuration using GoRouter.
///
/// Stage 3 provides routing for all Auth screens.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Home Screen (Stage 4)'),
        ),
      ),
    ),
  ],
);
