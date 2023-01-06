import 'package:flutter/material.dart';

import '../../../../../app.dart';
import '../../../domain/entities/entity.dart';
import '../../bloc/bloc.dart';
import '../../bloc/event.dart';
import 'house_number.dart';
import 'language.dart';
import 'theme_mode.dart';

class SettingsContentWidget extends StatelessWidget {
  final SettingsBloc bloc;
  final SettingsEntity entity;
  final BuildContext context;

  const SettingsContentWidget(
    this.bloc,
    this.entity,
    this.context, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final houseNumberController = TextEditingController(text: entity.houseNumber);
    final houseNumberFocusNode = FocusNode();

    houseNumberFocusNode.addListener(() {
      if (!houseNumberFocusNode.hasFocus && houseNumberController.text != entity.houseNumber) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        bloc.add(SettingsHouseNumberChanged(houseNumberController.text));
      }
    });

    return Column(
      children: [
        SettingsLanguageWidget(
          bloc,
          entity,
          (languageCode) => bloc.add(SettingsLanguageCodeChanged(languageCode, () => MyAppNotifications().dispatch(this.context))),
        ),
        SettingsThemeModeWidget(
          bloc,
          entity,
          (themeMode) => bloc.add(SettingsThemeModeChanged(themeMode, () => MyAppNotifications().dispatch(this.context))),
        ),
        SettingsHouseNumberWidget(
          bloc,
          entity,
        ),
      ],
    );
  }
}
