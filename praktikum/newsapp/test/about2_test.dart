import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:newsapp/page/search_page.dart';

void main() {
  testWidgets('Test Widget...', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SearchPage(),
    ));

    expect(find.text("Pilih Region Berita"), findsOneWidget);
    expect(find.text("Pilih Jenis Berita"), findsOneWidget);
  });
}
