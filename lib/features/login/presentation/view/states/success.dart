import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/routing/routing.dart';
import '../../../../../core/utils/translations.dart';

class LoginSuccessState extends StatelessWidget {
  const LoginSuccessState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                T()().login__success,
              ),
              const SizedBox(height: 16),
              TextButton(
                key: ValueKey(Testkey.login_homepageButton.toString()),
                onPressed: () => context.go(AppRouting.routeHome),
                child: Text(T()().general__homepage),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
