import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/mixins/repository.dart';
import '../../domain/entities/entity.dart';
import '../datasources/local/data_source.dart';
import '../models/model.dart';

class SettingsRepository with AppRepositoryMixin {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepository(this._localDataSource);

  SettingsEntity getSettings() => _localDataSource.getSettings();

  String getLanguageCode() => getSettings().languageCode;

  Future<Either<AppError, SettingsEntity>> update(SettingsEntity entity) async {
    return await either<SettingsEntity>(
      () async => await _localDataSource.setSettings(SettingsModel.fromEntity(entity)),
    );
  }
}
