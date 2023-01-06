import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../widgets/content.dart';

class SettingsDefaultState extends StatelessWidget {
  final SettingsBloc bloc;
  final SettingsDefault state;

  const SettingsDefaultState(
    this.bloc,
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SettingsContentWidget(bloc, state.entity, context),
    );
  }
}
