import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/config.dart';
import '../../../../../core/enums/testkey.dart';
import '../../../../../core/utils/translations.dart';
import '../../../../../core/widgets/drawer/drawer.dart';
import '../../../../../core/widgets/misc/error.dart';
import '../../../../../core/widgets/misc/loading_spinner.dart';
import '../../../../../core/widgets/misc/session_expired.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';
import 'states/default.dart';
import 'widgets/popup_menu.dart';

class CounterListPage extends StatelessWidget {
  final CounterListBloc _bloc;

  const CounterListPage(
    this._bloc, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        key: ValueKey(Testkey.counterList_page.toString()),
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: Text(T()().counter__counters),
          actions: [
            Visibility(
              visible: AppConfig().isLocal,
              child: CounterListPopupMenu(
                onSelected: (CounterListPopupMenuItem value) => _bloc.add(CounterListReset()),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CounterListBloc, CounterListState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is CounterListLoading) {
              return const AppLoadingSpinner();
            }

            if (state is CounterListDefault) {
              return CounterListDefaultState(state.entities);
            }

            if (state is CounterListError && state.error.code == 401) {
              return const AppSessionExpiredWidget();
            }

            return const AppGeneralErrorWidget();
          },
        ),
      ),
    );
  }
}
