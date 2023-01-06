import 'package:counter/core/enums/testkey.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_classes/test.dart';
import '../functions.dart';

class Logout implements TestWidget {
  @override
  Future<void> call() async {
    await ensureLogin();
    await openDrawer();
    await tapAndExpect(Testkey.drawer_menuLogout, Testkey.logout_page);
  }
}
