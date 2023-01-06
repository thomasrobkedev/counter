import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'core/config/config.dart';

Future<void> main() async {
  AppConfig().init(
    environment: AppEnvironment.dev,
    apiBaseUrl: AppConfig().apiMock,
  );

  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await app();
}
