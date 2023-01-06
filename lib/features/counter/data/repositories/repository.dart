import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/mixins/repository.dart';
import '../../domain/entities/entity.dart';
import '../datasources/remote/data_source.dart';
import '../models/model.dart';

class CounterRepository with AppRepositoryMixin {
  final CounterRemoteDataSource _remoteDataSource;

  CounterRepository(this._remoteDataSource);

  Future<Either<AppError, List<CounterEntity>>> getAll() async {
    return await either<List<CounterEntity>>(
      () => _remoteDataSource.getAll(),
    );
  }

  Future<Either<AppError, CounterEntity>> get(int id) async {
    return await either<CounterEntity>(
      () => _remoteDataSource.get(id),
    );
  }

  Future<Either<AppError, CounterEntity>> update(CounterEntity entity) async {
    return await either<CounterEntity>(
      () => _remoteDataSource.update(CounterModel.fromEntity(entity)),
    );
  }

  Future<Either<AppError, CounterEntity>> create(CounterEntity entity) async {
    return await either<CounterEntity>(
      () => _remoteDataSource.create(CounterModel.fromEntity(entity)),
    );
  }

  Future<Either<AppError, void>> delete(int id) async {
    return await either<void>(
      () => _remoteDataSource.delete(id),
    );
  }

  Future<Either<AppError, List<CounterEntity>>> reset() async {
    return await either<List<CounterEntity>>(
      () => _remoteDataSource.reset(),
    );
  }
}
