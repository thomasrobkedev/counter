import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../config/config.dart';

class AppApiToken {
  final _key = '${AppConfig().environment.name}Token';
  final Box _storage;

  AppApiToken(this._storage);

  String get() {
    return _storage.get(_key) ?? '';
  }

  Future<void> set(String value) async {
    return _storage.put(_key, value);
  }

  Future<void> delete() async {
    return _storage.delete(_key);
  }

  /// Ob das gespeicherte Token abgelaufen ist
  ///
  /// Die Funktion prüft nur das Feld [exp] des payloads. KEINE echte Validierung. Das geht nur mit dem server-seitigen Secret.
  /// Es reicht aber z.B. aus, um zu entscheiden, ob beim Start der App die Startseite oder gleich die Login-Seite aufgerufen wird.
  bool get isExpired {
    try {
      final isExpired = Jwt.isExpired(get());
      return isExpired;
    } catch (_) {
      return true;
    }
  }

  int get ttl {
    try {
      final expires = Jwt.getExpiryDate(get());
      return expires == null ? 0 : expires.difference(DateTime.now()).inSeconds;
    } catch (_) {
      return 0;
    }
  }
}
