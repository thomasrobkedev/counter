import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final void Function()? onPressed;
  final bool primary;

  const AppFilledButton({
    this.child,
    this.text,
    this.onPressed,
    this.primary = true,
    super.key,
  });

  const AppFilledButton.tonal({this.child, this.text, this.onPressed, super.key}) : primary = false;

  @override
  Widget build(BuildContext context) {
    if (child == null && text == null) {
      throw Exception('Either child or text must be provided');
    }

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primary ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: primary ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      onPressed: onPressed,
      child: child ?? Text(text!),
    );
  }
}
