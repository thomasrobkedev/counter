import 'package:flutter/material.dart';

import '../../../../../../core/enums/testkey.dart';
import '../../../../../../core/utils/translations.dart';
import '../../../../../../core/widgets/popup_menu/icon_item.dart';

enum CounterListPopupMenuItem { reset }

class CounterListPopupMenu extends StatelessWidget {
  final void Function(CounterListPopupMenuItem) onSelected;

  const CounterListPopupMenu({
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CounterListPopupMenuItem>(
      key: ValueKey(Testkey.counterList_popupMenu.toString()),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => [
        AppPopupMenuIconItem<CounterListPopupMenuItem>(
          text: T()().general__reset,
          value: CounterListPopupMenuItem.reset,
          icon: Icons.restart_alt,
          testKey: ValueKey(Testkey.counterList_popupMenu.appendWithUnderscore(CounterListPopupMenuItem.reset.name)),
        ),
      ],
    );
  }
}
