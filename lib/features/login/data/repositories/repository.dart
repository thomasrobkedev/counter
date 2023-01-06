import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/mixins/repository.dart';
import '../../domain/entities/entity.dart';
import '../datasources/remote/data_source.dart';
import '../models/model.dart';

class LoginRepository with AppRepositoryMixin {
  final LoginRemoteDataSource _remoteDataSource;

  LoginRepository(this._remoteDataSource);

  Future<Either<AppError, String>> login(LoginEntity entity) async {
    return await either<String>(
      () => _remoteDataSource.login(LoginModel.fromEntity(entity)),
    );
  }
}
