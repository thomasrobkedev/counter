import 'package:flutter/material.dart';

import '../../../../core/api/client.dart';
import '../../domain/entities/entity.dart';

class SettingsModel extends SettingsEntity {
  const SettingsModel({
    required super.themeMode,
    required super.languageCode,
    required super.houseNumber,
  });

  SettingsModel.fromJson(Json json)
      : this(
          themeMode: ThemeMode.values.firstWhere((value) => value.toString() == json['themeMode']),
          languageCode: json['languageCode'],
          houseNumber: json['houseNumber'],
        );

  Json toJson() {
    return {
      'themeMode': themeMode.toString(),
      'languageCode': languageCode,
      'houseNumber': houseNumber,
    };
  }

  SettingsModel.fromEntity(SettingsEntity entity)
      : this(
          themeMode: entity.themeMode,
          languageCode: entity.languageCode,
          houseNumber: entity.houseNumber,
        );
}
