import 'package:flutter/material.dart';

extension AppListDivided on Iterable {
  List<Widget> toListDivided({
    double indent = 16.0,
    double endIndent = 0.0,
    bool topLine = false,
    bool bottomLine = true,
  }) {
    final entries = toList().asMap().entries;

    Widget divider() {
      return Divider(
        height: 0,
        indent: indent,
        endIndent: endIndent,
      );
    }

    return entries
        .expand<Widget>(
          (entry) => [
            Visibility(visible: entry.key > 0 || topLine, child: divider()),
            entry.value,
            Visibility(visible: bottomLine, child: divider()),
          ],
        )
        .toList();
  }
}
