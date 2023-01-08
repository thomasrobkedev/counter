import 'package:counter/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    required this.title,
    required this.items,
    required this.callback,
    this.doneText,
    this.multiple = false,
    super.key,
  });

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    context.push(AppRouting.routeFullscreenDialog, extra: this);
  }

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
              // TODO: Übersetzuung
              child: Text(widget.doneText ?? 'Fertig'),
              onPressed: () {
                final values = widget.items //
                    .where((item) => item.selected)
                    .map((item) => item.value as T)
                    .toList();

                widget.callback(values);
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
