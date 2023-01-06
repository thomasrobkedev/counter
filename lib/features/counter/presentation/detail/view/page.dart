import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/routing/routing.dart';
import '../../../../../core/widgets/misc/error.dart';
import '../../../../../core/widgets/misc/loading_spinner.dart';
import '../../../../../core/widgets/misc/session_expired.dart';
import '../../../domain/entities/entity.dart';
import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';
import 'states/default.dart';
import 'states/error.dart';
import 'widgets/popup_menu.dart';

class CounterDetailPage extends StatelessWidget {
  final CounterDetailBloc _bloc;
  final String id;
  final String title;

  const CounterDetailPage(
    this._bloc, {
    super.key,
    required this.id,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<CounterDetailBloc, CounterDetailState>(
        listenWhen: (_, current) => current is CounterDetailDeleteSuccess,
        buildWhen: (_, current) => current is! CounterDetailDeleteSuccess,
        listener: (context, _) => context.go(AppRouting.routeCounters),
        builder: (context, state) {
          return Scaffold(
            key: ValueKey(Testkey.counterDetail_page.toString()),
            appBar: AppBar(
              title: Text(
                key: ValueKey(Testkey.counterDetail_title.toString()),
                title,
              ),
              actions: [
                CounterDetailPopupMenu(
                  title: title,
                  onConfirm: () => _bloc.add(CounterDetailPopupMenuDeletePressed(state.entity)),
                ),
              ],
            ),
            body: Builder(
              builder: (_) {
                if (state is CounterDetailLoading) {
                  _bloc.add(CounterDetailLoaded(const CounterEntity.empty(), int.parse(id)));
                  return const AppLoadingSpinner();
                }

                if (state is CounterDetailDefault) {
                  return CounterDetailDefaultState(_bloc, state);
                }

                if (state is CounterDetailError && state.error.code == 422) {
                  return CounterDetailErrorState(_bloc, state);
                }

                if (state is CounterDetailError && state.error.code == 401) {
                  return const AppSessionExpiredWidget();
                }

                return const AppGeneralErrorWidget();
              },
            ),
          );
        },
      ),
    );
  }
}
