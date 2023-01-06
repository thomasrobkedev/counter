import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsLoaded extends SettingsEvent {}

class SettingsThemeModeChanged extends SettingsEvent {
  final ThemeMode themeMode;
  final Function() rebuildApp;

  SettingsThemeModeChanged(this.themeMode, this.rebuildApp);
}

class SettingsLanguageCodeChanged extends SettingsEvent {
  final String languageCode;
  final Function() rebuildApp;

  SettingsLanguageCodeChanged(this.languageCode, this.rebuildApp);
}

class SettingsHouseNumberChanged extends SettingsEvent {
  final String houseNumber;

  SettingsHouseNumberChanged(this.houseNumber);
}
