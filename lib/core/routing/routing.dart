import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/counter/presentation/detail/view/page.dart';
import '../../features/counter/presentation/list/view/page.dart';
import '../../features/login/presentation/view/page.dart';
import '../../features/logout/presentation/view/page.dart';
import '../../features/settings/presentation/view/page.dart';
import '../api/token.dart';

class AppRouting {
  static const routeCounters = '/counters';
  static const routeNameCountersDetail = 'countersDetail';
  static const routeLogin = '/login';
  static const routeLogout = '/logout';
  static const routeSettings = '/settings';

  /// Wenn hier die Startseite geändert wird, muss das auch in den Tests angepasst werden. integration_test/functions.dart
  /// ```dart
  /// const homePageKey = Testkey.counterList_page;
  /// ```
  static const routeHome = routeCounters;

  final AppApiToken _token;
  late final GoRouter router;

  AppRouting(this._token) {
    final di = GetIt.instance;

    router = GoRouter(
      initialLocation: _token.isExpired ? routeLogin : routeHome,
      routes: <GoRoute>[
        GoRoute(
          path: routeLogin,
          builder: (context, state) => LoginPage(di()),
        ),
        GoRoute(
          path: routeLogout,
          builder: (context, state) => LogoutPage(di()),
        ),
        GoRoute(
          path: routeSettings,
          builder: (context, state) => SettingsPage(di()),
          routes: [
            GoRoute(
              path: 'language',
              pageBuilder: (context, state) => state.extra as Page,
            ),
            GoRoute(
              path: 'theme-mode',
              pageBuilder: (context, state) => state.extra as Page,
            ),
          ],
        ),
        GoRoute(
          path: routeCounters,
          builder: (context, state) => CounterListPage(di()),
          routes: [
            GoRoute(
              name: routeNameCountersDetail,
              path: ':id',
              builder: (context, state) {
                return CounterDetailPage(
                  di(),
                  id: state.params['id']!,
                  title: state.queryParams['title']!,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
