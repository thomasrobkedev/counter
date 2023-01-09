import 'package:flutter/material.dart';

import '../../../../../../core/enums/testkey.dart';
import '../../../../../../core/utils/translations.dart';
import '../../../../../../core/widgets/popup_menu/icon_item.dart';

enum CounterListPopupMenuItem { reset, reorder }

class CounterListPopupMenu extends StatelessWidget {
  final void Function() onReset;
  final void Function() onReorder;
  final bool reorderEnabled;

  const CounterListPopupMenu({
    required this.onReset,
    required this.onReorder,
    required this.reorderEnabled,
    super.key,
  });

  void onSelected(CounterListPopupMenuItem value) {
    switch (value) {
      case CounterListPopupMenuItem.reset:
        return onReset();
      case CounterListPopupMenuItem.reorder:
        return onReorder();
    }
  }

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
        const PopupMenuDivider(),
        AppPopupMenuIconItem<CounterListPopupMenuItem>(
          enabled: reorderEnabled,
          text: T()().counter__changeSequence,
          value: CounterListPopupMenuItem.reorder,
          icon: Icons.drag_handle,
          testKey: ValueKey(Testkey.counterList_popupMenu.appendWithUnderscore(CounterListPopupMenuItem.reorder.name)),
        ),
      ],
    );
  }
}
