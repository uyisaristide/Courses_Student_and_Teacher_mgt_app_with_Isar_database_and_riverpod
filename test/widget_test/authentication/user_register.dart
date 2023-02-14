import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_project/screens/auth_screens/register.dart';

import '../../paradigm.dart';

void main() async {
  late Widget root;

  setUp(() async {
    root = await settingLocal(
        widget: RegisterScreen(), startLocal: const Locale('en', 'US'));
  });
  group('Texts test', () {
    testWidgets('Test title', (tester) async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();
      expect(find.text("Register"), findsOneWidget);
      expect(find.text("Create a new account"), findsOneWidget);
      expect(find.text("Full Name"), findsNWidgets(2));
      expect(find.text("Email"), findsNWidgets(2));
      expect(find.text("Pasword"), findsNWidgets(2));
      expect(find.text("Confirm Password"), findsNWidgets(2));
      expect(find.text("Already have an account"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
    });
  });

  group('Test Validations', () {
    testWidgets('test error in validatition', (tester) async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();

      tester.tap(find.text('Sign Up'));
      // expect(, matcher)
    });
  });
}
