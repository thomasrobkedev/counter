import '../../../../core/api/token.dart';

class LogoutUseCaseDeleteToken {
  final AppApiToken _token;

  LogoutUseCaseDeleteToken(this._token);

  Future<void> call() async {
    return await _token.delete();
  }
}
