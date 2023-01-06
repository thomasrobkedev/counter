import 'package:flutter/material.dart';

class AppPopupMenuIconItem<T> extends PopupMenuItem<T> {
  AppPopupMenuIconItem({
    required String text,
    required T value,
    required IconData icon,
    bool enabled = true,
    ValueKey<String>? testKey,
  }) : super(
          key: testKey == null ? null : ValueKey(testKey.value + (enabled ? '--enabled' : '--disabled')),
          value: value,
          enabled: enabled,
          child: Row(
            children: [
              Container(
                width: 40,
                alignment: Alignment.centerLeft,
                child: Icon(icon),
              ),
              Flexible(child: Text(text)),
            ],
          ),
        );
}
