import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/config.dart';

Future<void> main() async {
  AppConfig().init(
    environment: AppEnvironment.test,
    apiBaseUrl: AppConfig().apiMock,
  );

  await app(key: UniqueKey());
}
