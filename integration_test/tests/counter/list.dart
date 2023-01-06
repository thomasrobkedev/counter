import 'package:counter/core/enums/testkey.dart';
import 'package:counter/core/utils/translations.dart';
import 'package:counter/features/counter/presentation/list/view/widgets/popup_menu.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_classes/test.dart';
import '../../functions.dart';

class CounterList implements TestWidget {
  @override
  Future<void> call() async {
    await ensureLogin();
    await openDrawer();
    await tapAndExpect(Testkey.drawer_menuCounters, Testkey.counterList_page);
    await wait(1);
    await tap(Testkey.counterList_popupMenu);
    await tap(Testkey.counterList_popupMenu.appendWithUnderscore(CounterListPopupMenuItem.reset.name).enabled);
    await wait(1);

    /// ________________________________________________________________________________
    /// List page: Namen, initiale Counter-Werte, Navigation zur Detail-Seite
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    for (var keyname in ['coffee', 'waterGlasses', 'overtime', 'cookies']) {
      await equalsString(Testkey.counterList_cardName.appendWithUnderscore(keyname), T().getByKeyname(keyname));
      await equalsString(Testkey.counterList_cardValue.appendWithUnderscore(keyname), '0');
      await tapAndExpect(Testkey.counterList_card.appendWithUnderscore(keyname), Testkey.counterDetail_page);
      await equalsString(Testkey.counterDetail_title, T().getByKeyname(keyname));
      await goBack();
    }
  }
}
