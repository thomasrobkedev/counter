import 'package:flutter/material.dart';

class CounterDetailButtonWidget extends StatelessWidget {
  final ValueKey<String> testKey;
  final Function()? onPressed;
  final IconData icon;

  const CounterDetailButtonWidget({
    super.key,
    required this.testKey,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          key: testKey,
          onPressed: onPressed,
          child: Icon(icon),
        ),
      ),
    );
  }
}
