import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsEntity extends Equatable {
  final ThemeMode themeMode;
  final String languageCode;
  final String houseNumber;

  const SettingsEntity({required this.themeMode, required this.languageCode, required this.houseNumber});
  const SettingsEntity.empty() : this(themeMode: ThemeMode.system, languageCode: '', houseNumber: '');

  SettingsEntity copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    String? houseNumber,
  }) {
    return SettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      houseNumber: houseNumber ?? this.houseNumber,
    );
  }

  @override
  List<Object> get props => [themeMode, languageCode, houseNumber];
}
