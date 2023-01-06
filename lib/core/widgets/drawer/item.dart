import 'package:flutter/material.dart';

class AppDrawerItem extends StatelessWidget {
  final ValueKey<String>? testKey;
  final String headline;
  final Widget? leading;
  final IconData? iconData;
  final bool enabled;
  final Function()? onTap;

  const AppDrawerItem({
    super.key,
    this.testKey,
    required this.headline,
    this.leading,
    this.iconData,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: testKey,
      title: Text(headline),
      leading: leading ?? Icon(iconData),
      enabled: enabled,
      onTap: onTap,
    );
  }
}
