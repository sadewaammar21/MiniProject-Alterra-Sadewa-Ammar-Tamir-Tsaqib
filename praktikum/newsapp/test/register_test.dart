import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/page/register/resgister_page.dart';

void main() {
  testWidgets('Test Widget...', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RegisterPage(),
    ));
    var textField = find.byType(TextFormField);
    expect(textField, findsNWidgets(2));
    await expectLater(find.text("Registrasi"), findsNWidgets(1));
    await expectLater(find.text("email"), findsNWidgets(1));
    await expectLater(find.text("Password"), findsNWidgets(1));
    expect(find.byType(ElevatedButton), findsNWidgets(1));
  });
}
