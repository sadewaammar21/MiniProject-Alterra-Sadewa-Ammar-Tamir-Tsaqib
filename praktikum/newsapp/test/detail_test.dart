import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/view/detail.dart';

void main() {
  testWidgets('Test Widget...', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Detail(),
    ));
    expect(find.byType(FloatingActionButton), findsNWidgets(1));
  });
}
