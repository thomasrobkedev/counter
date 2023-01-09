import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/extensions/list_divided.dart';
import '../../routing/routing.dart';
import '../../utils/translations.dart';
import 'item.dart';

class AppDropdown<Type> extends StatefulWidget {
  final String title;
  final List<AppDropdownItem> items;
  final Function(dynamic) callback;
  final bool multiple;

  const AppDropdown({
    required this.title,
    required this.items,
    required this.callback,
    this.multiple = false,
    super.key,
  });

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    context.push(AppRouting.routeFullscreenDialog, extra: this);
  }

  @override
  State<AppDropdown<Type>> createState() => _AppDropdownState<Type>();
}

class _AppDropdownState<Type> extends State<AppDropdown<Type>> {
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
              child: Text(T()().general__done),
              onPressed: () {
                final values = widget.items //
                    .where((item) => item.selected)
                    .map((item) => item.value as Type)
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
                      widget.callback(item.value as Type);
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
