import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:citywatch_canada/features/splash/splash_screen.dart';
import 'package:citywatch_canada/features/auth/welcome_screen.dart';
import 'package:citywatch_canada/features/auth/login_screen.dart';
import 'package:citywatch_canada/features/auth/register_screen.dart';
import 'package:citywatch_canada/features/home/main_layout.dart';
import 'package:citywatch_canada/features/home/home_screen.dart';
import 'package:citywatch_canada/features/home/categories_screen.dart';
import 'package:citywatch_canada/features/report/report_submit_screen.dart';


/// App-level router configuration using GoRouter.
///
/// Stage 4 configures Home screen and Shell routing.
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

    // Shell Route for Persistent Navigation Bar (Tabs)
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/map',
          name: 'map',
          builder: (context, state) => const Scaffold(
            body: Center(
              child: Text('Map View Screen (Stage 6)'),
            ),
          ),
        ),
        GoRoute(
          path: '/alerts',
          name: 'alerts',
          builder: (context, state) => const Scaffold(
            body: Center(
              child: Text('Neighborhood Alerts Screen (Stage 8)'),
            ),
          ),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const Scaffold(
            body: Center(
              child: Text('User Profile Screen (Stage 8)'),
            ),
          ),
        ),
      ],
    ),

    // Subpages outside bottom navigation shell
    GoRoute(
      path: '/categories',
      name: 'categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/report/submit',
      name: 'report_submit',
      builder: (context, state) {
        final category = state.uri.queryParameters['category'];
        return ReportSubmitScreen(initialCategory: category);
      },
    ),
    GoRoute(
      path: '/report/details',
      name: 'report_details',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Report Details View (Stage 7)'),
        ),
      ),
    ),
  ],
);
