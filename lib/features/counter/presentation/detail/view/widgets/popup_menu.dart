import 'package:flutter/material.dart';

import '../../../../../../core/config/config.dart';
import '../../../../../../core/enums/testkey.dart';
import '../../../../../../core/utils/translations.dart';
import '../../../../../../core/widgets/popup_menu/icon_item.dart';

enum CounterDetailPopupMenuItem { delete }

class CounterDetailPopupMenu extends StatelessWidget {
  final String title;
  final void Function() onConfirm;

  const CounterDetailPopupMenu({
    required this.title,
    required this.onConfirm,
    super.key,
  });

  void onSelected(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(T()().counter__confirmDelete),
        actions: <Widget>[
          TextButton(
            key: ValueKey(Testkey.counterDetail_confirmDialog_cancel.toString()),
            onPressed: () => Navigator.pop(context),
            child: Text(T()().general__cancel),
          ),
          TextButton(
            key: ValueKey(Testkey.counterDetail_confirmDialog_ok.toString()),
            onPressed: onConfirm,
            child: Text(T()().general__ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: AppConfig().isLocal,
      child: PopupMenuButton<CounterDetailPopupMenuItem>(
        key: ValueKey(Testkey.counterDetail_popupMenu.toString()),
        onSelected: (_) => onSelected(context),
        itemBuilder: (BuildContext context) => [
          AppPopupMenuIconItem<CounterDetailPopupMenuItem>(
            text: T()().general__delete,
            value: CounterDetailPopupMenuItem.delete,
            icon: Icons.delete,
            testKey: ValueKey(Testkey.counterDetail_popupMenu.appendWithUnderscore(CounterDetailPopupMenuItem.delete.name)),
          ),
        ],
      ),
    );
  }
}
