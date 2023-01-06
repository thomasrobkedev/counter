import '../../data/repositories/repository.dart';
import '../entities/entity.dart';

class SettingsUseCaseGetSettings {
  final SettingsRepository _repository;

  SettingsUseCaseGetSettings(this._repository);

  SettingsEntity call() {
    return _repository.getSettings();
  }
}
