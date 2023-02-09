import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_project/screens/auth_screens/login.dart';

import '../../paradigm.dart';

void main() {
  late Widget root;
  setUp(
    () {
      root = settingLocale(
          widgets: const LoginScreen(), startLocal: const Locale("en", "US"));
    },
  );

  group("trans", () {
    testWidgets("Trans", (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(root);
        await tester.idle();
        await tester.pumpAndSettle();
      });
      expect(find.text("Login"), findsOneWidget);
    });
  });
}
//   testWidgets('Test Login Page', (tester) async {
//     await tester.pumpWidget(settingLocale(
//         widgets: const LoginScreen(), startLocal: const Locale('en', 'US')));
//     // await tester.pumpWidget(const LoginScreen());
//     final findTitle = find.text("You are Welcome");
//     expect(findTitle, findsOneWidget);
//   });
// }
