import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:citywatch_canada/features/auth/welcome_screen.dart';
import 'package:citywatch_canada/features/auth/login_screen.dart';
import 'package:citywatch_canada/features/auth/register_screen.dart';

void main() {
  testWidgets('WelcomeScreen renders all options', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WelcomeScreen(),
      ),
    );

    // Verify Title and GovID Button
    expect(find.text('CityWatch Canada'), findsOneWidget);
    expect(find.text('Connect with GovID'), findsOneWidget);
    expect(find.text('Sign In with Email'), findsOneWidget);
    expect(find.text('Create Email Account'), findsOneWidget);
  });

  testWidgets('LoginScreen form validation works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Verify Title and Fields
    expect(find.text('Log In with Email'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Log In'), findsOneWidget);

    // Tap Log In to trigger validation errors
    await tester.tap(find.widgetWithText(ElevatedButton, 'Log In'));
    await tester.pumpAndSettle();

    // Verify validation errors are shown (since email & password are empty)
    expect(find.text('Please enter your email address.'), findsOneWidget);
    expect(find.text('Please enter your password.'), findsOneWidget);
  });

  testWidgets('RegisterScreen form validation and checkbox work', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RegisterScreen(),
      ),
    );

    // Verify Title
    expect(find.text('Create Account'), findsOneWidget);
    
    // Tap Create Account
    await tester.tap(find.widgetWithText(ElevatedButton, 'Create Account'));
    await tester.pumpAndSettle();

    // Verify validation errors
    expect(find.text('Please enter your full name.'), findsOneWidget);
    expect(find.text('Please enter your email address.'), findsOneWidget);
    expect(find.text('Please enter your password.'), findsOneWidget);
    expect(find.text('You must agree to the Terms of Service & Privacy Policy.'), findsOneWidget);
  });
}
