import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/config/config.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/model.dart';

class SettingsLocalDataSource {
  final _keySettings = '${AppConfig().environment.name}Settings';

  final SharedPreferences _prefs;

  SettingsLocalDataSource(this._prefs);

  SettingsModel? _settings;

  Future<void> clearSettings() async {
    _settings = null;
    await _prefs.remove(_keySettings);
  }

  Future<SettingsModel> setSettings(SettingsModel settings) async {
    _settings = settings;

    final str = jsonEncode(settings.toJson());

    if (!(await _prefs.setString(_keySettings, str))) {
      throw AppDataSourceException();
    }
    return _settings!;
  }

  SettingsModel getSettings() {
    if (_settings == null) {
      try {
        final json = jsonDecode(_prefs.getString(_keySettings) ?? '');
        _settings = SettingsModel.fromJson(json);
      } catch (_) {
        _settings = SettingsModel(themeMode: ThemeMode.system, languageCode: AppConfig().languageCodeNull, houseNumber: '');
        unawaited(setSettings(_settings!));
      }
    }

    return _settings!;
  }
}
