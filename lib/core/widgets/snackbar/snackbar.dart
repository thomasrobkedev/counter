import 'package:flutter/material.dart';

import '../../theme/custom_color.g.dart';

enum AppSnackbarType { system, success, info, warning }

class AppSnackbar {
  final String text;
  final AppSnackbarType type;

  const AppSnackbar(
    this.text,
    this.type,
  );

  AppSnackbar.system(this.text) : type = AppSnackbarType.system;
  AppSnackbar.success(this.text) : type = AppSnackbarType.success;
  AppSnackbar.info(this.text) : type = AppSnackbarType.info;
  AppSnackbar.warning(this.text) : type = AppSnackbarType.warning;

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _backgroundColor(context),
        duration: const Duration(seconds: 3),
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: _color(context)),
        ),
      ),
    );
  }

  Color? _color(BuildContext context) {
    switch (type) {
      case AppSnackbarType.system:
        return null;
      case AppSnackbarType.success:
        return Theme.of(context).extension<CustomColors>()?.onSuccessContainer;
      case AppSnackbarType.info:
        return Theme.of(context).extension<CustomColors>()?.onInfoContainer;
      case AppSnackbarType.warning:
        return Theme.of(context).extension<CustomColors>()?.onWarningContainer;
    }
  }

  Color? _backgroundColor(BuildContext context) {
    switch (type) {
      case AppSnackbarType.system:
        return null;
      case AppSnackbarType.success:
        return Theme.of(context).extension<CustomColors>()?.successContainer;
      case AppSnackbarType.info:
        return Theme.of(context).extension<CustomColors>()?.infoContainer;
      case AppSnackbarType.warning:
        return Theme.of(context).extension<CustomColors>()?.warningContainer;
    }
  }
}
