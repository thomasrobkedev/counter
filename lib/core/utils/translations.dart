import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../features/settings/domain/use_cases/get_language_code.dart';

class T {
  late GlobalKey<ScaffoldMessengerState> _key;
  late SettingsUseCaseGetLanguageCode _getLanguageCode;

  /// singleton
  static final T _instance = T._internal();
  factory T() => _instance;
  T._internal();

  void init(GlobalKey<ScaffoldMessengerState> key, SettingsUseCaseGetLanguageCode getLanguageCode) {
    _instance._key = key;
    _instance._getLanguageCode = getLanguageCode;
  }

  AppLocalizations call() => AppLocalizations.of(_context)!;
  BuildContext get _context => _key.currentContext!;

  String get currentLanguage => getLanguage(_getLanguageCode());

  String getLanguage(String? languageCode) {
    switch (languageCode) {
      case 'de':
        return call().settings__languageDE;
      case 'en':
        return call().settings__languageEN;
      default:
        return call().settings__languageSystem;
    }
  }

  String getByKeyname(String keyname) {
    switch (keyname) {
      case 'coffee':
        return call().counter__coffee;
      case 'waterGlasses':
        return call().counter__waterGlasses;
      case 'overtime':
        return call().counter__overtime;
      case 'cookies':
        return call().counter__cookies;
      default:
        return keyname;
    }
  }
}
