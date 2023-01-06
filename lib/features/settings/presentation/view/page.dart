import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/testkey.dart';
import '../../../../core/utils/translations.dart';
import '../../../../core/widgets/drawer/drawer.dart';
import '../../../../core/widgets/misc/error.dart';
import '../../../../core/widgets/misc/loading_spinner.dart';
import '../bloc/bloc.dart';
import '../bloc/state.dart';
import 'states/default.dart';
import 'states/error.dart';
import 'states/success.dart';

class SettingsPage extends StatelessWidget {
  final SettingsBloc _bloc;

  const SettingsPage(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        key: ValueKey(Testkey.settings_page.toString()),
        appBar: AppBar(
          key: ValueKey(Testkey.settings_title.toString()),
          title: Text(T()().menu__settings),
        ),
        drawer: const AppDrawer(),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const AppLoadingSpinner();
            }

            if (state is SettingsDefault) {
              return SettingsDefaultState(_bloc, state);
            }

            if (state is SettingsSuccess) {
              return SettingsSuccessState(_bloc, state);
            }

            if (state is SettingsError) {
              return SettingsErrorState(_bloc, state);
            }

            return const AppGeneralErrorWidget();
          },
        ),
      ),
    );
  }
}
