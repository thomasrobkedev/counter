import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/routing/routing.dart';
import '../../../../../core/utils/translations.dart';

class LogoutSuccessState extends StatelessWidget {
  const LogoutSuccessState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                T()().logout__success,
              ),
              const SizedBox(height: 16),
              TextButton(
                key: ValueKey(Testkey.logout_loginButton.toString()),
                onPressed: () => context.go(AppRouting.routeLogin),
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
