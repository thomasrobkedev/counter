import 'dart:async';

import 'package:flutter/material.dart';

class AppLoadingSpinner extends StatefulWidget {
  final int delay;
  const AppLoadingSpinner({super.key, this.delay = 500});

  @override
  State<AppLoadingSpinner> createState() => _AppLoadingSpinnerState();
}

class _AppLoadingSpinnerState extends State<AppLoadingSpinner> {
  bool _active = false;
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(Duration(milliseconds: widget.delay), () => setState(() => _active = true));
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_active) {
      return Container();
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
