import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/utils/translations.dart';
import '../../../../core/widgets/drawer/drawer.dart';
import '../../../../core/widgets/misc/error.dart';
import '../../../../core/widgets/misc/loading_spinner.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';
import 'states/success.dart';

class LogoutPage extends StatelessWidget {
  final LogoutBloc _bloc;

  const LogoutPage(this._bloc, {super.key});

  void close(BuildContext context, Function() onTap) {
    Navigator.pop(context);
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        key: ValueKey(Testkey.logout_page.toString()),
        appBar: AppBar(title: Text(T()().general__logout)),
        drawer: const AppDrawer(),
        body: BlocBuilder<LogoutBloc, LogoutState>(
          builder: (context, state) {
            if (state is LogoutLoading) {
              return const AppLoadingSpinner();
            }

            if (state is LogoutSuccess) {
              return const LogoutSuccessState();
            }

            return const AppGeneralErrorWidget();
          },
        ),
      ),
    );
  }
}
