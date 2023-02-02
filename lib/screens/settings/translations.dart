import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home_screen/widgets/entity_button.dart';

class LanguageChange extends StatelessWidget {
  const LanguageChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EntityButtons(
            buttonColor: const Color(0Xff1DA1F2),
            mediaIcon: Icons.flag,
            media: "English Us",
            onPressed: () {
              context.setLocale(const Locale('en', 'US'));
              context.push('/register');
            },
          ),
          EntityButtons(
            buttonColor: const Color(0Xff1DA1F2),
            mediaIcon: Icons.flag_circle,
            media: "French",
            onPressed: () {
              context.setLocale(
                const Locale('fr', 'FR'),
              );
              context.push('/register');
            },
          ),
          EntityButtons(
            buttonColor: const Color(0Xff1DA1F2),
            mediaIcon: Icons.flag_sharp,
            media: "Kinyarwanda",
            onPressed: () {
              context.push('/register');
            },
          ),
        ],
      ),
    );
  }
}
