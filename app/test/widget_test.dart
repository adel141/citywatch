import 'package:flutter_test/flutter_test.dart';
import 'package:citywatch_canada/app/citywatch_app.dart';

void main() {
  testWidgets('CityWatchApp starts up and renders Splash Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CityWatchApp());
    await tester.pumpAndSettle();

    // Verify that the title 'CityWatch Canada' is present on the splash screen
    expect(
      find.byWidgetPredicate((widget) =>
          widget is RichText &&
          widget.text.toPlainText().contains('CityWatch')),
      findsWidgets,
    );

    // Verify tagline or button is present
    expect(find.textContaining('Report local issues'), findsOneWidget);
  });
}
