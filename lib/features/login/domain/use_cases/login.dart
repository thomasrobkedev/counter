import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../../data/repositories/repository.dart';
import '../entities/entity.dart';
import 'save_token.dart';

class LoginUseCaseLogin {
  final LoginRepository _repository;
  final LoginUseCaseSaveToken _saveToken;

  LoginUseCaseLogin(this._repository, this._saveToken);

  Future<Either<AppError, String>> call(LoginEntity entity) async {
    final result = await _repository.login(entity);

    if (result.isRight()) {
      final token = result.getOrElse(() => '');
      await _saveToken(token);
    }

    return result;
  }
}
