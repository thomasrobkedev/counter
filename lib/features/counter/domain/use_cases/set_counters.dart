import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class CounterUseCaseSetCounters {
  final CounterRepository _repository;

  CounterUseCaseSetCounters(this._repository);

  Future<Either<AppError, List<CounterEntity>>> call(List<CounterEntity> entities) async {
    await Future.wait(
      entities.map((entity) => _repository.update(entity)),
    );

    return await _repository.getAll();
  }
}
