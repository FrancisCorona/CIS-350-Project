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

}


