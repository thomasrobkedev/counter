import 'package:flutter/material.dart';

import 'color_schemes.g.dart';
import 'custom_color.g.dart';

class AppTheme {
  ThemeData getThemeData(BuildContext context, {required bool light}) {
    final colorScheme = light ? lightColorScheme : darkColorScheme;
    const bodyMediumFontSize = 15.0;
    const bodyMediumTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: bodyMediumFontSize);

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'MemoryScriptNormal',
      colorScheme: colorScheme,
      extensions: [light ? lightCustomColors : darkCustomColors],

      textTheme: TextTheme(
        bodyLarge: bodyMediumTextStyle.copyWith(fontSize: bodyMediumFontSize + 2),
        bodyMedium: bodyMediumTextStyle,
        bodySmall: bodyMediumTextStyle.copyWith(fontSize: bodyMediumFontSize - 2),

        /// Globales Setzen des ListTile title fontsize
        /// * in Material 2 wird es noch nicht unterstützt. Darum der Umweg über titleMedium.
        /// * in Material 3: via listTileTheme.
        ///   https://github.com/flutter/flutter/pull/117965
        ///   https://github.com/flutter/flutter/issues/114006
        titleMedium: bodyMediumTextStyle,
      ),
      //   listTileTheme: ListTileThemeData(
      //     titleTextStyle: bodyMediumTextStyle,
      //   ),

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
        titleTextStyle: AppBarTheme.of(context).titleTextStyle?.copyWith(fontFamily: 'MemoryScriptNord'),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          for (var targetPlatform in TargetPlatform.values) targetPlatform: const CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
