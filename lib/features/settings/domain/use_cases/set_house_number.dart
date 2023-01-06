import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class SettingsUseCaseSetHouseNumber {
  final SettingsRepository _repository;

  SettingsUseCaseSetHouseNumber(this._repository);

  Future<Either<AppError, SettingsEntity>> call(String houseNumber) async {
    return await _repository.update(
      _repository.getSettings().copyWith(houseNumber: houseNumber),
    );
  }
}
