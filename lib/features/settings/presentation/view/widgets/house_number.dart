import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/utils/translations.dart';
import '../../../domain/entities/entity.dart';
import '../../bloc/bloc.dart';
import '../../bloc/event.dart';

class SettingsHouseNumberWidget extends StatelessWidget {
  final SettingsBloc bloc;
  final SettingsEntity entity;

  const SettingsHouseNumberWidget(
    this.bloc,
    this.entity, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: entity.houseNumber);
    final focusNode = FocusNode();

    focusNode.addListener(() {
      if (!focusNode.hasFocus && controller.text != entity.houseNumber) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        bloc.add(SettingsHouseNumberChanged(controller.text));
      }
    });

    return ListTile(
      key: ValueKey(Testkey.settings_houseNumber.toString()),
      onTap: () => focusNode.requestFocus(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            T()().general__houseNumber,
            key: ValueKey(Testkey.settings_languageLabel.toString()),
          ),
          SizedBox(
            width: 40,
            child: TextField(
              key: ValueKey(Testkey.settings_houseNumberValue.toString()),
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              focusNode: focusNode,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(4),
              ],
            ),
          ),
        ],
      ),
      trailing: GestureDetector(
        onTap: () {
          controller.clear();
          focusNode.requestFocus();
        },
        child: Icon(
          Icons.clear,
          size: 20,
          key: ValueKey(Testkey.settings_houseNumberClear.toString()),
        ),
      ),
    );
  }
}
