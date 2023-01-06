enum AppEnvironment { dev, test, release }

class AppConfig {
  late bool _initialized = false;

  final List<String> supportedLocales = ['de', 'en', 'hr', 'hu', 'nl', 'pl', 'sk', 'cs', 'bg', 'sl', 'ro', 'sr', 'lv', 'lt', 'et'];
  final languageCodeNull = 'system';
  final apiMock = 'mock';

  /// Die folgenden Werte werden vom jeweiligen Environment (main.dart, main_test.dart, etc) in die App gegeben
  late final AppEnvironment environment;
  late final String apiBaseUrl;

  /// singleton
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  void init({
    required AppEnvironment environment,
    required String apiBaseUrl,
  }) {
    /// Mehrfach-Ausführung bei Integrationstests verhindern
    if (_instance._initialized) {
      if (environment == AppEnvironment.test) {
        return;
      }
      throw ('AppConfig already initialized');
    }

    _instance._initialized = true;
    _instance.environment = environment;
    _instance.apiBaseUrl = apiBaseUrl;
  }

  bool get isTest => environment == AppEnvironment.test;
  bool get isLocal => environment == AppEnvironment.test || environment == AppEnvironment.dev;
}
