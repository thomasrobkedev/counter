import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class CounterUseCaseGetCounter {
  final CounterRepository _repository;

  CounterUseCaseGetCounter(this._repository);

  Future<Either<AppError, CounterEntity>> call(int id) async {
    return await _repository.get(id);
  }
}
