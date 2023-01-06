import 'package:counter/core/config/config.dart';
import 'package:counter/core/enums/testkey.dart';
import 'package:counter/core/utils/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_classes/test.dart';
import '../functions.dart';

class Settings implements TestWidget {
  @override
  Future<void> call() async {
    await clearSettings();
    await ensureLogout(); // settings soll auch ausgelogged funktionieren
    await openDrawer();
    await tapAndExpect(Testkey.drawer_menuSettings, Testkey.settings_page);

    final systemBrightness = SchedulerBinding.instance.window.platformBrightness.name;
    final systemDesign = systemBrightness == ThemeMode.light.name ? T()().general__light : T()().general__dark;
    final systemLanguageCode = SchedulerBinding.instance.window.locale.toString().substring(0, 2);

    /// ________________________________________________________________________________
    /// Theme: system, light, dark
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    final expected = {
      ThemeMode.system: '${T()().general__system} ($systemDesign)',
      ThemeMode.light: T()().general__light,
      ThemeMode.dark: T()().general__dark,
    }.entries;

    for (var entry in expected) {
      await tapAndExpect(Testkey.settings_theme, Testkey.dropdown);
      await tapAndExpect(Testkey.dropdown_item.appendWithUnderscore(entry.key), Testkey.settings_page);
      await equalsString(Testkey.settings_themeValue, entry.value);
      await tapAndExpect(Testkey.settings_theme, Testkey.dropdown);
      await exists(Testkey.dropdown_item_icon.appendWithUnderscore(entry.key));
      await close();
    }

    /// ________________________________________________________________________________
    /// Sprache: system, dann alle unterstützen Sprachen
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    final locales = [AppConfig().languageCodeNull, ...AppConfig().supportedLocales];

    for (var locale in locales) {
      await tapAndExpect(Testkey.settings_language, Testkey.dropdown);
      await tapAndExpect(Testkey.dropdown_item.appendWithUnderscore(locale), Testkey.settings_page);
      await equalsString(Testkey.settings_title, T()().menu__settings);
      await equalsString(Testkey.settings_languageLabel, T()().settings__language);
      await equalsString(Testkey.settings_languageValue, locale == AppConfig().languageCodeNull ? '${T()().general__system} ($systemLanguageCode)' : T().getLanguage(locale));
      await tapAndExpect(Testkey.settings_language, Testkey.dropdown);
      await exists(Testkey.dropdown_item_icon.appendWithUnderscore(locale));
      await close();
    }

    /// ________________________________________________________________________________
    /// Hausnummer: 471, 471, leer. Beim 1.+3. wird gespeichert. Beim 2. nicht.
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    await enterTextAndSubmit(Testkey.settings_houseNumberValue, '471');
    await tester.pump();
    await hasText(T()().general__saved);
    await wait(5); // default SnackBar timeout = 3 sec
    await tap(Testkey.settings_houseNumberValue);
    await inputSubmit();
    await tester.pump();
    await notHasText(T()().general__saved);
    await tap(Testkey.settings_houseNumberClear);
    await inputSubmit();
    await tester.pump();
    await hasText(T()().general__saved);
    await wait(5);

    /// ________________________________________________________________________________
    /// Wir prüfen, ob die Einstellungen auch einen Neustart überleben
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    await tapAndExpect(Testkey.settings_language, Testkey.dropdown);
    await tapAndExpect(Testkey.dropdown_item.appendWithUnderscore(systemLanguageCode == 'de' ? 'en' : 'de'), Testkey.settings_page);
    await startupApp();
    await openDrawer();
    await equalsString(Testkey.drawer_menuSettings, systemLanguageCode == 'de' ? 'Settings' : 'Einstellungen');
    await tap(Testkey.drawer);
  }
}
