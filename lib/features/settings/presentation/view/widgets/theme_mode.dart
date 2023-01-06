import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/routing/routing.dart';
import '../../../../../core/utils/translations.dart';
import '../../../../../core/widgets/dropdown/dropdown.dart';
import '../../../../../core/widgets/dropdown/item.dart';
import '../../../domain/entities/entity.dart';
import '../../bloc/bloc.dart';

class SettingsThemeModeWidget extends StatelessWidget {
  final SettingsBloc bloc;
  final SettingsEntity entity;
  final Function(dynamic) callback;

  const SettingsThemeModeWidget(
    this.bloc,
    this.entity,
    this.callback, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(Testkey.settings_theme.toString()),
      trailing: const Icon(Icons.navigate_next),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            T()().general__design,
            key: ValueKey(Testkey.settings_themeLabel.toString()),
          ),
          Text(
            _getDesign(context, entity.themeMode),
            key: ValueKey(Testkey.settings_themeValue.toString()),
          ),
        ],
      ),
      onTap: () => context.push(
        '${AppRouting.routeSettings}/theme-mode',
        extra: MaterialPage(
          fullscreenDialog: true,
          child: AppDropdown<ThemeMode>(
            title: T()().general__design,
            callback: callback,
            items: [ThemeMode.system, ThemeMode.light, ThemeMode.dark]
                .map(
                  (themeMode) => AppDropdownItem<ThemeMode>(
                    title: Text(_getDesign(context, themeMode)),
                    value: themeMode,
                    selected: entity.themeMode == themeMode,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  String _getDesign(BuildContext context, ThemeMode themeMode) {
    return themeMode == ThemeMode.system ? '${T()().general__system} (${_getSystemBrightness(context)})' : _getBrightness(themeMode.name);
  }

  String _getBrightness(String name) {
    return name == ThemeMode.light.name ? T()().general__light : T()().general__dark;
  }

  String _getSystemBrightness(BuildContext context) {
    return _getBrightness(MediaQuery.of(context).platformBrightness.name);
  }
}
