import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../errors/errors.dart';

mixin AppRepositoryMixin {
  Future<Either<AppError, T>> either<T>(Future<T> Function() request) async {
    try {
      final result = await request();
      return Right(result);
    } on AppDataSourceException catch (e) {
      return Left(AppDataSourceError(e.code, e.message));
    }
  }
}
