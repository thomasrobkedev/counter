import 'package:flutter/material.dart';

import '../../../../../core/utils/translations.dart';
import '../../../../../core/widgets/snackbar/snackbar.dart';
import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../widgets/content.dart';

class SettingsSuccessState extends StatelessWidget {
  final SettingsBloc bloc;
  final SettingsSuccess state;

  const SettingsSuccessState(
    this.bloc,
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => AppSnackbar.success(T()().general__saved).show(context));

    return SingleChildScrollView(
      child: SettingsContentWidget(bloc, state.entity, context),
    );
  }
}
