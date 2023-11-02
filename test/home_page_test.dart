import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:lakervent/main.dart';
import 'package:lakervent/pages/home_page.dart';

void main() {
  // Test the creation of HomePage widget:
  testWidgets('Test if HomePage widget can be created', (WidgetTester tester) async {
    // Build widget.
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Expected widget with LakerVent text in the app bar.
    expect(find.text('LakerVent'), findsOneWidget);
  });

  // Test New Post button goes to the Post page.
  testWidgets('Test if "New Post" button navigates to PostPage', (WidgetTester tester) async {
  // Build widget.
  await tester.pumpWidget(MaterialApp(home: HomePage()));

  // Simulate tap on button.
  await tester.tap(find.text("New Post"));
  await tester.pumpAndSettle();

  // Check if Create a New Post is on the screen.
  expect(find.text("Create a New Post"), findsOneWidget); // Replace with the text you expect on the PostPage
});

}


