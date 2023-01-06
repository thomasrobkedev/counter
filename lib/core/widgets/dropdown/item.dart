import 'package:flutter/material.dart';

class AppDropdownItem<T> {
  final Widget? title;
  final Widget? subtitle;
  final T value;
  bool selected;
  bool enabled;

  AppDropdownItem({
    this.title,
    this.subtitle,
    required this.value,
    this.selected = false,
    this.enabled = true,
  });
}
