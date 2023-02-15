import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_project/screens/auth_screens/register.dart';
import 'package:isar_project/screens/auth_screens/widgets/authentication_button.dart';
import 'package:isar_project/screens/auth_screens/widgets/custom_text_field.dart';

import '../../paradigm.dart';

void main() async {
  late Widget root;

  setUp(() async {
    root = await settingLocal(
        widget: RegisterScreen(), startLocal: const Locale('en', 'US'));
  });
  group('Texts test', () {
    testWidgets('Test if texts are rendered', (tester) async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();
      expect(find.text("Register"), findsOneWidget);
      expect(find.text("Create a new account"), findsOneWidget);
      expect(find.text("Full Name"), findsNWidgets(2));
      expect(find.text("Email"), findsNWidgets(2));
      expect(find.text("Password"), findsNWidgets(2));
      expect(find.text("Confirm Password"), findsNWidgets(2));
      expect(find.text("Already have an account ?"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
    });
  });

  group('Test if Validations are working properly and scrollable behaviour',
      () {
    testWidgets('test error in validatition', (tester) async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();
      //  Scrolling the screen
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -150));
      //  tap on button and displays validation errors

      await tester.tap(find.byType(AuthenticationButton));
      await tester.pump();
      expect(find.text('Enter password'), findsNWidgets(2));
      //  fill in textField and expects no error
      await tester.enterText(
          find.widgetWithText(CustomTextField, 'Full Name'), 'My name');
      await tester.enterText(
          find.widgetWithText(CustomTextField, 'Email'), 'email@me.com');
      await tester.enterText(
          find.widgetWithText(CustomTextField, 'Password'), 'password');
      await tester.enterText(
          find.widgetWithText(CustomTextField, 'Email'), 'email@me.com');

      await tester.tap(find.byType(AuthenticationButton));
      await tester.pump();

      expect(find.text('Enter username'), findsOneWidget);
    });
  });

  testWidgets(
    "Test if widgets are rendered",
    (WidgetTester tester) async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();

      expect(find.byType(CustomTextField), findsNWidgets(4));
    },
  );
}
