import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/config/config.dart';
import '../../../../../core/enums/testkey.dart';
import '../../../../../core/utils/translations.dart';
import '../../../../../core/widgets/dropdown/dropdown.dart';
import '../../../../../core/widgets/dropdown/item.dart';
import '../../../domain/entities/entity.dart';
import '../../bloc/bloc.dart';

class SettingsLanguageWidget extends StatelessWidget {
  final SettingsBloc bloc;
  final SettingsEntity entity;
  final Function(dynamic) callback;

  const SettingsLanguageWidget(
    this.bloc,
    this.entity,
    this.callback, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(Testkey.settings_language.toString()),
      trailing: const Icon(Icons.navigate_next),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            T()().settings__language,
            key: ValueKey(Testkey.settings_languageLabel.toString()),
          ),
          Text(
            T().currentLanguage + (entity.languageCode == AppConfig().languageCodeNull ? ' (${Platform.localeName.substring(0, 2)})' : ''),
            key: ValueKey(Testkey.settings_languageValue.toString()),
          ),
        ],
      ),
      onTap: () {
        AppDropdown<String>(
          title: T()().settings__language,
          callback: callback,
          items: [
            AppDropdownItem<String>(
              title: Text('${T().getLanguage(AppConfig().languageCodeNull)} (${Platform.localeName.substring(0, 2)})'),
              value: AppConfig().languageCodeNull,
              selected: entity.languageCode == AppConfig().languageCodeNull,
            ),
            ...AppConfig().supportedLocales.map(
                  (languageCode) => AppDropdownItem<String>(
                    title: Text(T().getLanguage(languageCode)),
                    value: languageCode,
                    selected: entity.languageCode == languageCode,
                  ),
                ),
          ],
        ).show(context);
      },
    );
  }
}
