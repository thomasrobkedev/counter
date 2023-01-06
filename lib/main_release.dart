import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'core/config/config.dart';

Future<void> main() async {
  AppConfig().init(
    environment: AppEnvironment.release,
    apiBaseUrl: 'https://h[[HOUSE]].puc/api', // [[HOUSE]] wird in der App eingesetzt
  );

  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await app();
}
