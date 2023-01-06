import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../enums/testkey.dart';
import '../../routing/routing.dart';
import '../../utils/translations.dart';

class AppSessionExpiredWidget extends StatelessWidget {
  const AppSessionExpiredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                T()().general__sessionExpired,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextButton(
                key: ValueKey(Testkey.sessionExpired_loginButton.toString()),
                onPressed: () => context.pushReplacement(AppRouting.routeLogin),
                child: Text(T()().general__login),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
