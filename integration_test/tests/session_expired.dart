import 'package:counter/core/enums/testkey.dart';
import 'package:counter/core/utils/translations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_classes/test.dart';
import '../functions.dart';

class SessionExpired implements TestWidget {
  @override
  Future<void> call() async {
    await login(pNumber: '000003'); // Token TTL 3 Sekunden
    await hasText(T()().login__success);
    await wait(5);
    await tap(Testkey.login_homepageButton);
    await wait(1);
    await hasText(T()().general__sessionExpired);
  }
}
