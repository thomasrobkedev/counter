import 'package:counter/core/enums/testkey.dart';
import 'package:counter/core/utils/translations.dart';
import 'package:counter/features/counter/presentation/detail/view/widgets/popup_menu.dart';
import 'package:counter/features/counter/presentation/list/view/widgets/popup_menu.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../_classes/test.dart';
import '../../functions.dart';

class CounterDetail implements TestWidget {
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
    /// Detail page: am Beispiel "Kaffee"
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    const keyname = 'coffee';

    /// Wir tappen auf den coffee counter, navigieren zur Detailseite und warten auch hier kurz auf die Api
    await tapAndExpect(Testkey.counterList_card.appendWithUnderscore(keyname), Testkey.counterDetail_page);
    await wait(1);

    /// Wir checken den Namen und den initialen Wert auf der Detail-Seite
    await equalsString(Testkey.counterDetail_title, T().getByKeyname(keyname));
    await equalsString(Testkey.counterDetail_value, '0');

    /// Button plus
    await tap(Testkey.counterDetail_buttonPlus);
    await wait(1);
    await equalsString(Testkey.counterDetail_value, '1');

    /// Button minus, inkl. SnackBar bei nochmaligem tap
    await tap(Testkey.counterDetail_buttonMinus);
    await wait(1);
    await equalsString(Testkey.counterDetail_value, '0');
    await tap(Testkey.counterDetail_buttonMinus);
    await tester.pump();
    await hasText(T()().counter__decrementHint);
    await equalsString(Testkey.counterDetail_value, '0');

    /// Button reset
    await tap(Testkey.counterDetail_buttonPlus);
    await wait(1);
    await equalsString(Testkey.counterDetail_value, '1');
    await tap(Testkey.counterDetail_buttonReset);
    await wait(1);
    await equalsString(Testkey.counterDetail_value, '0');

    /// ________________________________________________________________________________
    /// Zurück zur List page: Dort prüfen wir, ob der Wert von der Detail-Seite korrekt übernommen wurde
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    await tap(Testkey.counterDetail_buttonPlus);
    await wait(1);
    await equalsString(Testkey.counterDetail_value, '1');
    await goBack();
    await wait(1);
    await equalsString(Testkey.counterList_cardValue.appendWithUnderscore(keyname), '1');

    /// ________________________________________________________________________________
    /// Löschen des Counters "Kaffee" und Wiederherstellen durch Reset
    /// ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    await tapAndExpect(Testkey.counterList_card.appendWithUnderscore(keyname), Testkey.counterDetail_page);
    await wait(1);
    await tap(Testkey.counterDetail_popupMenu);
    await tap(Testkey.counterDetail_popupMenu.appendWithUnderscore(CounterDetailPopupMenuItem.delete.name).enabled);
    await wait(1);
    await tapAndExpect(Testkey.counterDetail_confirmDialog_ok, Testkey.counterList_page);
    await notExists(Testkey.counterList_cardName.appendWithUnderscore(keyname));
    await tap(Testkey.counterList_popupMenu);
    await tap(Testkey.counterList_popupMenu.appendWithUnderscore(CounterListPopupMenuItem.reset.name).enabled);
    await wait(1);
    await exists(Testkey.counterList_cardName.appendWithUnderscore(keyname));
  }
}
