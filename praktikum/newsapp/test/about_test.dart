import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/page/login/login_page.dart';

void main() {
  testWidgets('Judul Nama harus..', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));
    expect(find.text("Login"), findsOneWidget);
  });
}
