import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../widgets/content.dart';

class CounterDetailDefaultState extends StatelessWidget {
  const CounterDetailDefaultState(
    this.bloc,
    this.state, {
    super.key,
  });

  final CounterDetailBloc bloc;
  final CounterDetailDefault state;

  @override
  Widget build(BuildContext context) {
    return CounterDetailContentWidget(bloc, state.entity);
  }
}
