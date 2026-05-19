import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:citywatch_canada/features/home/home_screen.dart';
import 'package:citywatch_canada/features/home/categories_screen.dart';

void main() {
  testWidgets('HomeScreen renders greeting, search, grid, map, and list', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify greetings
    expect(find.text('Welcome back,'), findsOneWidget);
    expect(find.text('Alex Mercer'), findsOneWidget);

    // Verify search bar presence
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search for active reports or locations...'), findsOneWidget);

    // Verify category header & some popular items
    expect(find.text('Explore Categories'), findsOneWidget);
    expect(find.text('Pothole'), findsOneWidget);
    expect(find.text('Streetlight'), findsOneWidget);
    expect(find.text('See All'), findsOneWidget);

    // Verify map preview
    expect(find.text('Nearby Activity'), findsOneWidget);
    expect(find.text('Queen Street Area'), findsOneWidget);
    expect(find.text('8 Active reports within 500m'), findsOneWidget);

    // Verify list of recent reports
    expect(find.text('Recent Reports'), findsOneWidget);
    expect(find.text('Large pothole in center lane'), findsOneWidget);
    expect(find.text('Flickering streetlight bulb'), findsOneWidget);
  });

  testWidgets('CategoriesScreen filters categories correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CategoriesScreen(),
      ),
    );

    // Verify title and search bar
    expect(find.text('All Categories'), findsOneWidget);
    expect(find.text('Search categories...'), findsOneWidget);

    // Verify some initial categories are present
    expect(find.text('Pothole'), findsOneWidget);
    expect(find.text('Animal Control'), findsOneWidget);
    expect(find.text('Graffiti'), findsOneWidget);

    // Type 'pothole' in search field
    await tester.enterText(find.byType(TextField), 'pothole');
    await tester.pump();

    // Verify 'Pothole' is visible, and 'Animal Control' is hidden
    expect(find.text('Pothole'), findsOneWidget);
    expect(find.text('Animal Control'), findsNothing);

    // Type a query that matches nothing
    await tester.enterText(find.byType(TextField), 'xyzabc');
    await tester.pump();

    // Verify empty state message
    expect(find.text('No categories match your search.'), findsOneWidget);
  });
}
