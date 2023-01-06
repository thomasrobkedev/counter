import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

import 'core/config/config.dart';
import 'core/routing/routing.dart';
import 'core/theme/theme.dart';
import 'core/utils/translations.dart';
import 'dependency_injection.dart';
import 'features/settings/domain/use_cases/get_settings.dart';

Future<void> app({Key? key}) async {
  final di = GetIt.I;
  await DependencyInjection().init();
  T().init(di(), di());
  runApp(MyApp(di(), di(), di(), di(), key: key));
}

/// type annotation für den NotificationListener unten
class MyAppNotifications extends Notification {}

class MyApp extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  final AppTheme _theme;
  final AppRouting _routing;
  final SettingsUseCaseGetSettings _getSettings;

  const MyApp(
    this._scaffoldMessengerKey,
    this._theme,
    this._routing,
    this._getSettings, {
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    final locale = widget._getSettings().languageCode == AppConfig().languageCodeNull //
        ? Locale(Platform.localeName.substring(0, 2))
        : Locale.fromSubtags(languageCode: widget._getSettings().languageCode);

    return NotificationListener<MyAppNotifications>(
      onNotification: (MyAppNotifications notifications) {
        setState(() {});
        return true;
      },
      child: GestureDetector(
        /// Einklappen der virtuellen Tastatur beim tap außerhalb eines Input-Feldes - egal wo.
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          title: 'Pickliste&Verkauf',
          themeMode: widget._getSettings().themeMode,
          theme: widget._theme.getThemeData(context, light: true),
          darkTheme: widget._theme.getThemeData(context, light: false),
          locale: locale,
          supportedLocales: AppConfig().supportedLocales.map((languageCode) => Locale(languageCode)),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routeInformationProvider: widget._routing.router.routeInformationProvider,
          routeInformationParser: widget._routing.router.routeInformationParser,
          routerDelegate: widget._routing.router.routerDelegate,
          scaffoldMessengerKey: widget._scaffoldMessengerKey,
        ),
      ),
    );
  }
}
