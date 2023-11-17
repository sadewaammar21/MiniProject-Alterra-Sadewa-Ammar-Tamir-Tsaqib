import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/page/home_page.dart'; // Update with your correct file path

void main() {
  testWidgets('Test Widget...', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage(),
    ));

    expect(find.text("NewsApp"), findsOneWidget);
    expect(find.text("Confirm"), findsOneWidget);
    expect(find.text("Apakah anda yakin ingin keluar"), findsOneWidget);
    await tester.tap(find.byIcon(Icons.logout));
  });
}
