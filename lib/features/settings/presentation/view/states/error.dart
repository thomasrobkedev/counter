import 'package:flutter/material.dart';

import '../../../../../core/utils/translations.dart';
import '../../../../../core/widgets/banner/banner.dart';
import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../widgets/content.dart';

class SettingsErrorState extends StatelessWidget {
  final SettingsBloc bloc;
  final SettingsError state;

  const SettingsErrorState(
    this.bloc,
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBanner.error(T()().general__generalError),
          SettingsContentWidget(bloc, state.entity, context),
        ],
      ),
    );
  }
}
