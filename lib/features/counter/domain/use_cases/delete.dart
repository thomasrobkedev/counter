import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class CounterUseCaseDelete {
  final CounterRepository _repository;

  CounterUseCaseDelete(this._repository);

  Future<Either<AppError, void>> call(CounterEntity entity) async {
    return await _repository.delete(entity.id);
  }
}
