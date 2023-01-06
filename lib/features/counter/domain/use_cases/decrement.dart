import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class CounterUseCaseDecrement {
  final CounterRepository _repository;

  CounterUseCaseDecrement(this._repository);

  Future<Either<AppError, CounterEntity>> call(CounterEntity entity) async {
    return await _repository.update(entity.copyWith(value: entity.value - 1));
  }
}
