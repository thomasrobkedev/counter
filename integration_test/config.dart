import '_classes/test.dart';
import 'tests/counter/detail.dart';
import 'tests/counter/list.dart';
import 'tests/login.dart';
import 'tests/logout.dart';
import 'tests/session_expired.dart';
import 'tests/settings.dart';

typedef Root = Group;
typedef Counter = Group;

///    1 = execute
///    0 = skip
/// null = inherit

final tests = Root(1, [
  Test(null, Settings()),
  Test(null, Login()),
  Test(null, Logout()),
  Test(null, SessionExpired()),
  Counter(null, [
    Test(null, CounterList()),
    Test(null, CounterDetail()),
  ]),
]);
