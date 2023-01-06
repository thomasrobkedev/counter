import 'package:flutter/material.dart';

import '../../../../../../core/utils/translations.dart';
import '../../../../../../core/widgets/snackbar/snackbar.dart';
import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../widgets/content.dart';

class CounterDetailErrorState extends StatelessWidget {
  const CounterDetailErrorState(
    this.bloc,
    this.state, {
    super.key,
  });

  final CounterDetailBloc bloc;
  final CounterDetailError state;

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    /// derzeit gibt es nur den zero underflow error. Sonst müsste hier noch feiner unterschieden werden
    if (state.error.code == 422) {
      WidgetsBinding.instance.addPostFrameCallback((_) => AppSnackbar.warning(context, T()().counter__decrementHint).show());
    }

    return CounterDetailContentWidget(bloc, state.entity);
  }
}
