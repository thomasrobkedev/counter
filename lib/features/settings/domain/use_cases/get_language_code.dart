import '../../data/repositories/repository.dart';

class SettingsUseCaseGetLanguageCode {
  final SettingsRepository _repository;

  SettingsUseCaseGetLanguageCode(this._repository);

  String call() {
    return _repository.getLanguageCode();
  }
}
