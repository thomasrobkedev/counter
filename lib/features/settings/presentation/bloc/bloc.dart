import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entity.dart';
import '../../domain/use_cases/get_settings.dart';
import '../../domain/use_cases/set_house_number.dart';
import '../../domain/use_cases/set_language_code.dart';
import '../../domain/use_cases/set_theme_mode.dart';
import 'event.dart';
import 'state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsUseCaseGetSettings _getSettings;
  final SettingsUseCaseSetThemeMode _setThemeMode;
  final SettingsUseCaseSetLanguageCode _setLanguageCode;
  final SettingsUseCaseSetHouseNumber _setHouseNumber;

  SettingsBloc(this._getSettings, this._setThemeMode, this._setLanguageCode, this._setHouseNumber) : super(const SettingsLoading(SettingsEntity.empty())) {
    on<SettingsLoaded>(_onLoaded);
    on<SettingsThemeModeChanged>(_onThemeModeChanged);
    on<SettingsLanguageCodeChanged>(_onLanguageCodeChanged);
    on<SettingsHouseNumberChanged>(_onHouseNumberChanged);

    add(SettingsLoaded());
  }

  void _onLoaded(SettingsLoaded event, Emitter<SettingsState> emit) {
    emit(SettingsDefault(_getSettings()));
  }

  Future<void> _onThemeModeChanged(SettingsThemeModeChanged event, Emitter<SettingsState> emit) async {
    final result = await _setThemeMode(event.themeMode);

    result.fold(
      (error) => emit(SettingsError(_getSettings(), error)),
      (data) => event.rebuildApp(),
    );
  }

  Future<void> _onLanguageCodeChanged(SettingsLanguageCodeChanged event, Emitter<SettingsState> emit) async {
    final result = await _setLanguageCode(event.languageCode);

    result.fold(
      (error) => emit(SettingsError(_getSettings(), error)),
      (data) => event.rebuildApp(),
    );
  }

  Future<void> _onHouseNumberChanged(SettingsHouseNumberChanged event, Emitter<SettingsState> emit) async {
    final result = await _setHouseNumber(event.houseNumber);

    result.fold(
      (error) => emit(SettingsError(_getSettings(), error)),
      (data) => emit(SettingsSuccess(data)),
    );
  }
}
