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
        return call().settings__language_german;
      case 'en':
        return call().settings__language_english;
      case 'hr':
        return call().settings__language_croatian;
      case 'hu':
        return call().settings__language_hungarian;
      case 'nl':
        return call().settings__language_dutch;
      case 'pl':
        return call().settings__language_polish;
      case 'sk':
        return call().settings__language_slovakian;
      case 'cs':
        return call().settings__language_czech;
      case 'bg':
        return call().settings__language_bulgarian;
      case 'sl':
        return call().settings__language_slovenian;
      case 'ro':
        return call().settings__language_romanian;
      case 'sr':
        return call().settings__language_serbian;
      case 'lv':
        return call().settings__language_latvian;
      case 'lt':
        return call().settings__language_lithuanian;
      case 'et':
        return call().settings__language_estonian;
      default:
        return call().settings__language_system;
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
