import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class SettingsUseCaseSetLanguageCode {
  final SettingsRepository _repository;

  SettingsUseCaseSetLanguageCode(this._repository);

  Future<Either<AppError, SettingsEntity>> call(String languageCode) async {
    return await _repository.update(
      _repository.getSettings().copyWith(languageCode: languageCode),
    );
  }
}
