import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/utils/translations.dart';
import '../../../../core/widgets/drawer/drawer.dart';
import '../../../../core/widgets/misc/error.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';
import 'states/default.dart';
import 'states/error.dart';
import 'states/success.dart';

class LoginPage extends StatelessWidget {
  final LoginBloc _bloc;

  const LoginPage(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        key: ValueKey(Testkey.login_page.toString()),
        appBar: AppBar(title: Text(T()().general__login)),
        drawer: const AppDrawer(),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            // if (state is LoginLoading) {
            //   return const AppLoadingSpinner();
            // }

            if (state is LoginDefault) {
              return LoginDefaultState(_bloc, state);
            }

            if (state is LoginSuccess) {
              return const LoginSuccessState();
            }

            if (state is LoginError) {
              return LoginErrorState(_bloc, state);
            }

            return const AppGeneralErrorWidget();
          },
        ),
      ),
    );
  }
}
