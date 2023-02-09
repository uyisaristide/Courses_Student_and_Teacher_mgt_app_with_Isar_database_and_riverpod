import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Widget settingLocale({required Widget widgets, required Locale startLocal}) {
  return EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('rw', 'RW')
      ],
      assetLoader: const RootBundleAssetLoader(),
      startLocale: startLocal,
      useFallbackTranslations: true,
      path: 'assets/translations',
      child: ProviderScope(child: Builder(builder: (BuildContext context) {
        return MaterialApp.router(
          
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          
          routerDelegate: getGoRouter(widgets).routerDelegate,
            routeInformationParser: getGoRouter(widgets).routeInformationParser,
            routeInformationProvider: getGoRouter(widgets).routeInformationProvider,
          debugShowCheckedModeBanner: false,
        );
      })));
}

GoRouter getGoRouter(Widget w) {
  return GoRouter(routes: [
    GoRoute(
        path: '/languages',
        builder: (context, state) {
          return Material(child: w);
        })
  ]);
}
