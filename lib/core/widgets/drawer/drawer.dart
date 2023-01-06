import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../enums/testkey.dart';
import '../../routing/routing.dart';
import '../../utils/translations.dart';
import 'item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void close(BuildContext context, Function() onTap) {
    onTap();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Drawer(
        key: ValueKey(Testkey.drawer.toString()),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 70,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Container(),
                  leading: const Icon(Icons.menu),
                ),
              ),
            ),
            AppDrawerItem(
              testKey: ValueKey(Testkey.drawer_menuCounters.toString()),
              headline: 'Flutter Demo (${T()().counter__counters})',
              leading: const FlutterLogo(),
              onTap: () => close(context, () => context.go(AppRouting.routeCounters)),
            ),
            AppDrawerItem(
              testKey: ValueKey(Testkey.drawer_menuSettings.toString()),
              headline: T()().menu__settings,
              iconData: Icons.settings,
              onTap: () => close(context, () => context.go(AppRouting.routeSettings)),
            ),
            AppDrawerItem(
              testKey: ValueKey(Testkey.drawer_menuLogin.toString()),
              headline: T()().general__login,
              iconData: Icons.login,
              onTap: () => close(context, () => context.go(AppRouting.routeLogin)),
            ),
            AppDrawerItem(
              testKey: ValueKey(Testkey.drawer_menuLogout.toString()),
              headline: T()().general__logout,
              iconData: Icons.logout,
              onTap: () => close(context, () => context.go(AppRouting.routeLogout)),
            ),
          ],
        ),
      ),
    );
  }
}
