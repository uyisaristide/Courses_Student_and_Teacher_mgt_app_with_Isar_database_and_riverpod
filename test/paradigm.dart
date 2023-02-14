import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'json_loader.dart';


Future<Widget> settingLocal(
    {required Widget widget,
    required Locale startLocal,
    List<Override> overrides = const []}) async {
  var path =
      "assets/translations/${startLocal.toStringWithSeparator(separator: "-")}.json";
  var s = json.decode(await rootBundle.loadString(path));
  return Builder(builder: (context) {
    return EasyLocalization(
      fallbackLocale: const Locale('en', 'US'),
      useFallbackTranslations: true,
      assetLoader: JsonAssetLoader(data: Map<String, dynamic>.from(s)),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('rw', 'RW')
      ],
      saveLocale: false,
      startLocale: startLocal,
      path: 'assets/translations',
      child: ProviderScope(
        overrides: overrides,
        child: Builder(
          builder: (BuildContext context) {
            return MaterialApp.router(
              localizationsDelegates: [
                ...context.localizationDelegates,
                // RwCupertinoLocalizations.delegate,
                // RwMaterialLocalizations.delegate
              ],
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              routerDelegate: getGoRouter(widget).routerDelegate,
              routeInformationParser:
                  getGoRouter(widget).routeInformationParser,
              routeInformationProvider:
                  getGoRouter(widget).routeInformationProvider,
            );
          },
        ),
      ),
    );
  });
}

GoRouter getGoRouter(Widget w) {
  return GoRouter(routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          return Material(child: w);
        })
  ], initialLocation: "/");
}