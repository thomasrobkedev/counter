import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class SettingsUseCaseSetThemeMode {
  final SettingsRepository _repository;

  SettingsUseCaseSetThemeMode(this._repository);

  Future<Either<AppError, SettingsEntity>> call(ThemeMode themeMode) async {
    return await _repository.update(
      _repository.getSettings().copyWith(themeMode: themeMode),
    );
  }
}
