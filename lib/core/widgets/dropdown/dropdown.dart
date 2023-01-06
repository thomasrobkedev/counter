import 'package:flutter/material.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import 'item.dart';

class AppDropdown<T> extends StatefulWidget {
  final String title;
  final List<AppDropdownItem> items;
  final Function(dynamic) callback;
  final String? doneText;
  final bool multiple;

  const AppDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.callback,
    this.doneText,
    this.multiple = false,
  });

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Testkey.dropdown.toString()),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Visibility(
            visible: widget.multiple,
            child: TextButton(
              child: Text(widget.doneText ?? 'Fertig'),
              onPressed: () {
                widget.callback(widget.items.where((item) => item.selected).toList() as List<T>);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: widget.items
              .map(
                (AppDropdownItem item) => ListTile(
                  key: ValueKey(Testkey.dropdown_item.appendWithUnderscore(item.value)),
                  title: item.title,
                  selected: item.selected,
                  enabled: item.enabled,
                  trailing: item.selected
                      ? Icon(
                          Icons.check,
                          key: ValueKey(Testkey.dropdown_item_icon.appendWithUnderscore(item.value)),
                        )
                      : null,
                  onTap: () {
                    if (widget.multiple) {
                      setState(() => item.selected = !item.selected);
                    } else {
                      widget.callback(item.value as T);
                      Navigator.pop(context);
                    }
                  },
                ),
              )
              .toListDivided(),
        ),
      ),
    );
  }
}
