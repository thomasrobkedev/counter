import 'package:flutter/material.dart';

class AppResponsiveCol extends StatelessWidget {
  /// [Bootstrap Breakpoints](https://getbootstrap.com/docs/5.0/layout/breakpoints/)
  final double? xs; // <576px
  final double? sm; // ≥576px
  final double? md; // ≥768px
  final double? lg; // ≥992px
  final double? xl; // ≥1200px
  final double? xxl; // ≥1400px
  final Widget child;

  const AppResponsiveCol({super.key, this.xs, this.sm, this.md, this.lg, this.xl, this.xxl, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        var widthFactor = xs ?? 1.0;

        if (width >= 1440) {
          widthFactor = xxl ?? 1 / 6;
        } else if (width >= 1200) {
          widthFactor = xl ?? 1 / 5;
        } else if (width >= 992) {
          widthFactor = lg ?? 1 / 4;
        } else if (width >= 768) {
          widthFactor = md ?? 1 / 3;
          // eigentlich 576. Siehe oben. Aber für TC21 runter gesetzt.
        } else if (width >= 500) {
          widthFactor = sm ?? 1 / 2;
        }

        return FractionallySizedBox(
          widthFactor: widthFactor * 0.9999, // avoid row breaks caused by pixel rounding errors
          child: child,
        );
      },
    );
  }
}
