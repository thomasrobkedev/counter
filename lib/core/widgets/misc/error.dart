import 'package:flutter/material.dart';

import '../../utils/translations.dart';

class AppGeneralErrorWidget extends StatelessWidget {
  const AppGeneralErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        T()().general__generalError,
        textAlign: TextAlign.center,
      ),
    );
  }
}
