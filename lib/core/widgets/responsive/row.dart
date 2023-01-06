import 'package:flutter/material.dart';

import 'col.dart';

class AppResponsiveRow extends StatelessWidget {
  final List<AppResponsiveCol> children;

  const AppResponsiveRow({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: children,
      ),
    );
  }
}
