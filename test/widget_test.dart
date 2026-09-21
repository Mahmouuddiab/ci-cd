import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ci_demo/main.dart';

void main() {
  testWidgets('Counter increments and resets', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    // Tap the reset icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('0'), findsOneWidget);
  });
}
