import 'package:flutter/material.dart';

enum AppBannerType { error }

class AppBanner extends StatelessWidget {
  final AppBannerType type;
  final String text;

  const AppBanner(
    this.type,
    this.text, {
    super.key,
  });

  const AppBanner.error(this.text, {super.key}) : type = AppBannerType.error;

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: _backgroundColor(context),
      leading: _icon(context),
      content: Text(text),
      contentTextStyle: TextStyle(color: _color(context)),
      actions: [Container()],
    );
  }

  Color _color(BuildContext context) {
    switch (type) {
      case AppBannerType.error:
        return Theme.of(context).colorScheme.onError;
    }
  }

  Color _backgroundColor(BuildContext context) {
    switch (type) {
      case AppBannerType.error:
        return Theme.of(context).colorScheme.error;
    }
  }

  Icon _icon(BuildContext context) {
    switch (type) {
      case AppBannerType.error:
        return Icon(Icons.cancel_outlined, color: _color(context));
    }
  }
}
