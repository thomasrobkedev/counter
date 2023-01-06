import 'package:flutter/material.dart';

import 'color_schemes.g.dart';
import 'custom_color.g.dart';

class AppTheme {
  ThemeData getThemeData(BuildContext context, {required bool light}) {
    final colorScheme = light ? lightColorScheme : darkColorScheme;
    final listTileTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize);

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'MemoryScriptNormal',
      colorScheme: colorScheme,
      extensions: [light ? lightCustomColors : darkCustomColors],
      textTheme: TextTheme(
        titleMedium: listTileTextStyle, // M2
        bodyLarge: listTileTextStyle, // M3, https://github.com/flutter/flutter/issues/114006
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer,
          foregroundColor: colorScheme.onSecondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorScheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'MemoryScriptNord',
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          color: colorScheme.onSurface,
        ),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          for (var targetPlatform in TargetPlatform.values) targetPlatform: const CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  ButtonStyle primaryButtonStyle(BuildContext context) {
    return TextButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }
}
