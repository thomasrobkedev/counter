import 'package:counter/core/enums/testkey.dart';
import 'package:counter/core/utils/translations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_classes/test.dart';
import '../functions.dart';

class Login implements TestWidget {
  @override
  Future<void> call() async {
    await ensureLogout();
    await openDrawer();
    await tapAndExpect(Testkey.drawer_menuLogin, Testkey.login_page);

    /// ________________________________________________________________________________
    /// fails
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    await enterText(Testkey.login_pNumber, '');
    await enterText(Testkey.login_password, 'test123');
    await tapAndExpect(Testkey.login_submitButton, Testkey.login_page);
    await wait(1);
    await hasText(T()().login__authorizationError);

    await enterText(Testkey.login_pNumber, '123456');
    await enterText(Testkey.login_password, '');
    await tapAndExpect(Testkey.login_submitButton, Testkey.login_page);
    await wait(1);
    await hasText(T()().login__authorizationError);

    /// ________________________________________________________________________________
    /// success
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    await enterText(Testkey.login_pNumber, '123456');
    await enterText(Testkey.login_password, 'test123');
    await tapAndExpect(Testkey.login_submitButton, Testkey.login_page);
    await wait(1);
    await exists(Testkey.login_homepageButton);
  }
}
