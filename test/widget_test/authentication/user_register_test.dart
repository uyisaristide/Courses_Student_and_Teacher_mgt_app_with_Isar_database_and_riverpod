import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_project/screens/auth_screens/register.dart';
import 'package:isar_project/screens/auth_screens/widgets/authentication_button.dart';
import 'package:isar_project/screens/auth_screens/widgets/custom_text_field.dart';

import '../../paradigm.dart';

void main() async {
  late Widget root;
  late Widget rootFrench;
  final nameField = find.byKey(const ValueKey('name'));
  final emailField = find.byKey(const ValueKey('email'));
  final passwordField = find.byKey(const ValueKey('password'));
  final cpasswordField = find.byKey(const ValueKey('cpassword'));

  setUp(() async {
    root = await settingLocal(
        widget: RegisterScreen(), startLocal: const Locale('en', 'US'));
    rootFrench = await settingLocal(
        widget: RegisterScreen(), startLocal: const Locale('fr', 'FR'));
  });
  group('Texts test', () {
    testWidgets('Test if texts are rendered', (tester) async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();

      // check if all texts are rendered
      expect(find.text("Register"), findsOneWidget);
      expect(find.text("Create a new account"), findsOneWidget);
      expect(find.text("Full Name"), findsNWidgets(2));
      expect(find.text("Email"), findsNWidgets(2));
      expect(find.text("Password"), findsNWidgets(2));
      expect(find.text("Confirm Password"), findsNWidgets(2));
      expect(find.text("Already have an account ?"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
      // test number of text fields rendered
      expect(find.byType(CustomTextField), findsNWidgets(4));
    });
  });

  group('Test if Validations are working properly and scrollable behaviour',
      () {
    testWidgets('Test that for form is not valitated ', (tester) async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pumpAndSettle();
      //  Scrolling the screen
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -150));
      //  tap on button and displays validation errors

      await tester.tap(find.byType(AuthenticationButton));
      await tester.pump();
      expect(find.text('Enter username'), findsOneWidget);
      expect(find.text('Enter Email'), findsOneWidget);
      expect(find.text('Enter password'), findsNWidgets(2));
    });
  });
  testWidgets('Test fo invalid email Address and invalid password',
      (tester) async {
    await tester.pumpWidget(root);
    await tester.idle();
    await tester.pumpAndSettle();
    //  Scrolling the screen
    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -150));

    // Test email validity
    await tester.enterText(emailField, 'email');
    await tester.enterText(passwordField, 'pass');

    await tester.tap(find.byType(AuthenticationButton));
    await tester.pumpAndSettle();
    expect(find.text('Minimum characters for password are 6'), findsOneWidget);
    expect(find.text('Invalid Email'), findsOneWidget);
    
  });

  testWidgets('Test that form is validated', (tester) async {
    await tester.pumpWidget(root);
    await tester.idle();
    await tester.pumpAndSettle();
    //  Scrolling the screen
    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -150));

    //  fill in textField and expects no error

    await tester.enterText(nameField, 'email@me.com');
    await tester.enterText(emailField, 'email@me.com');
    await tester.enterText(passwordField, 'email@me.com');
    await tester.enterText(cpasswordField, 'email@me.com');

    await tester.tap(find.byType(AuthenticationButton));

    // await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('Enter username'), findsNothing);
    expect(find.text('Enter Email'), findsNothing);
    expect(find.text('Enter password'), findsNothing);
  });

  testWidgets(
    "Test if french locale works",
    (WidgetTester tester) async {
      await tester.pumpWidget(rootFrench);
      await tester.idle();
      await tester.pumpAndSettle();
      expect(find.text('E-mail'), findsNWidgets(2));
      expect(find.text('Mot de passe'), findsNWidgets(2));
    },
  );
}
