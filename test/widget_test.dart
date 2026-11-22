import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:team_connect/widgets/member_placeholder.dart';

void main() {
  testWidgets('Member placeholder shows profile details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MemberPlaceholderScreen(
          name: 'Test Member',
          registrationNumber: '23IT0000',
        ),
      ),
    );

    expect(find.text('Test Member'), findsNWidgets(2));
    expect(find.text('23IT0000'), findsOneWidget);
    expect(find.text('Profile under development'), findsOneWidget);
  });
}
