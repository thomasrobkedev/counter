import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class CounterUseCaseGetCounters {
  final CounterRepository _repository;

  CounterUseCaseGetCounters(this._repository);

  Future<Either<AppError, List<CounterEntity>>> call() async {
    return await _repository.getAll();
  }
}
