import '../../../../core/api/token.dart';

class LoginUseCaseSaveToken {
  final AppApiToken _token;

  LoginUseCaseSaveToken(this._token);

  Future<void> call(String token) async {
    return await _token.set(token);
  }
}
