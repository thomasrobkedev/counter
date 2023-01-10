import 'package:counter/core/api/token.dart';
import 'package:counter/core/enums/testkey.dart';
import 'package:counter/features/settings/data/datasources/local/data_source.dart';
import 'package:counter/main_test.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

late WidgetTester tester;
const homePageKey = Testkey.counterList_page;

/// Wird vor jedem Start eines Tests automatisch aufgerufen. Kann aber auch zwischendurch manuell aufgerufen werden.
Future<void> startupApp([WidgetTester? activeTester]) async {
  tester = activeTester ?? tester;
  await app.main();
  await tester.pumpAndSettle();
}

Future<void> login({String pNumber = '123456'}) async {
  await openDrawer();
  await tapAndExpect(Testkey.drawer_menuLogin, Testkey.login_page);
  await enterText(Testkey.login_pNumber, pNumber);
  await enterText(Testkey.login_password, 'test123');
  await tapAndExpect(Testkey.login_submitButton, Testkey.login_page);
  await wait(1);
}

Future<void> logout() async {
  await openDrawer();
  await tapAndExpect(Testkey.drawer_menuLogout, Testkey.logout_page);
}

Future<void> ensureLogin() async {
  if (AppApiToken(GetIt.I()).ttl < 3600) {
    await login();
  }
}

Future<void> ensureLogout() async {
  if (!AppApiToken(GetIt.I()).isExpired) {
    await logout();
  }
}

Future<void> openDrawer() async {
  final state = tester.firstState(find.byType(Scaffold).first) as ScaffoldState;
  state.openDrawer();
  await tester.pumpAndSettle();
}

Future<void> clearSettings() async {
  await SettingsLocalDataSource(GetIt.I()).clearSettings();
  await startupApp();
}

T getWidget<T>(dynamic testkey) {
  final finder = find.byKey(ValueKey(testkey.toString()));
  return finder.evaluate().single.widget as T;
}

/// tap + long press
/// --------------------------------------------------

Future<void> tap(dynamic testkey) async {
  await tester.ensureVisible(_find(testkey));
  await tester.tap(_find(testkey));
  await tester.pumpAndSettle();
}

Future<void> tapAndExpect(dynamic tapTestkey, dynamic expectTestkey) async {
  await tap(tapTestkey);
  expect(_find(expectTestkey), findsWidgets);
}

Future<void> tapAndExpectText(dynamic tapTestkey, String expectText) async {
  await tap(tapTestkey);
  expect(_findText(expectText), findsWidgets);
}

Future<void> tapOnText(String text) async {
  await tester.tap(find.widgetWithText(IndexedSemantics, text));
  await tester.pumpAndSettle();
}

Future<void> tapOnScreenTopLeftCorner() async {
  await tester.tapAt(const Offset(10, 10));
  await tester.pumpAndSettle();
}

Future<void> longPress(dynamic longPressTestkey) async {
  await tester.longPress(_find(longPressTestkey));
  await tester.pumpAndSettle();
}

Future<void> longPressAndExpect(dynamic longPressTestkey, dynamic expectTestkey) async {
  await longPress(longPressTestkey);
  expect(_find(expectTestkey), findsWidgets);
}

Future<void> longPressAndExpectText(dynamic longPressTestkey, String expectText) async {
  await longPress(longPressTestkey);
  expect(_findText(expectText), findsWidgets);
}

Future<void> drag(dynamic testkey, {double offsetX = 0.0, double offsetY = 0.0}) async {
  await tester.drag(_find(testkey), Offset(offsetX, offsetY));
  await tester.pumpAndSettle();
}

/// text input
/// --------------------------------------------------

Future<void> enterText(dynamic inputTestkey, String inputText) async {
  await tester.enterText(_find(inputTestkey), inputText);
  await tester.pumpAndSettle();
}

Future<void> enterTextAndSubmit(dynamic inputTestkey, String inputText) async {
  await enterText(inputTestkey, inputText);
  await inputSubmit();
}

Future<void> enterTextAndSubmitAndExpect(dynamic inputTestkey, String inputText, dynamic expectTestkey) async {
  await enterTextAndSubmit(inputTestkey, inputText);
  expect(_find(expectTestkey), findsWidgets);
}

Future<void> enterTextAndSubmitAndExpectText(dynamic inputTestkey, String inputText, String expectText) async {
  await enterTextAndSubmit(inputTestkey, inputText);
  expect(_findText(expectText), findsWidgets);
}

Future<void> deleteText(dynamic inputTestkey, int characterCount) async {
  await enterText(inputTestkey, '');
}

Future<void> inputSubmit() async {
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
}

/// test functions
/// --------------------------------------------------

Future<void> equalsString(dynamic inputTestkey, String expected) async {
  final widget = tester.widget(_find(inputTestkey).first);

  if (widget is TextFormField) {
    return expect(widget.controller!.text, expected);
  }
  if (widget is Text) {
    return expect(widget.data, expected);
  }
  if (widget is AppBar) {
    return expect((widget.title as Text).data, expected);
  }
  if (widget is ListTile) {
    return expect((widget.title as Text).data, expected);
  }

  throw Exception('Unknown type of text field');
}

Future<void> checkObscuredPassword(dynamic inputTestkey, bool expectedResult) async {
  final passwordTextFormField = find.descendant(
    of: _find(inputTestkey),
    matching: find.byType(EditableText),
  );
  final input = tester.widget<EditableText>(passwordTextFormField);
  expect(input.obscureText, expectedResult);
}

Future<void> equalsValue(dynamic a, dynamic b) async {
  expect(a, b);
}

Future<void> equalsTrue(bool a) async {
  expect(a, true);
}

Future<void> equalsFalse(bool a) async {
  expect(a, false);
}

Future<void> hasText(String text) async {
  expect(find.text(text), findsWidgets);
}

Future<void> notHasText(String text) async {
  expect(find.text(text), findsNothing);
}

Future<void> exists(dynamic testkey) async {
  expect(_find(testkey), findsWidgets);
}

Future<void> notExists(dynamic testkey) async {
  expect(_find(testkey), findsNothing);
}

/// navigation
/// --------------------------------------------------
Future<void> close() async {
  await tester.tap(find.byType(CloseButton));
  await tester.pumpAndSettle();
}

Future<void> goBack() async {
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
}

Future<void> goHome() async {
  while (find.byType(BackButton).evaluate().isNotEmpty) {
    await goBack();
  }

  await exists(homePageKey);
}

/// util
/// --------------------------------------------------

Finder _find(dynamic testkey) {
  return find.byKey(ValueKey(testkey.toString()));
}

Finder _findText(Pattern expectText) {
  return find.textContaining(expectText);
}

Future<void> wait(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  await tester.pumpAndSettle();
}

Future<void> hold() async {
  await Future.delayed(const Duration(seconds: 300));
}

Future<void> scroll(dynamic testkey, double delta) async {
  await tester.scrollUntilVisible(_find(testkey), delta, scrollable: find.byType(Scrollable).first);
  await tester.pumpAndSettle();
}

Future<String> getTextFromField(dynamic inputTestkey) async {
  final w = tester.widget(_find(inputTestkey));
  if (w is TextFormField) {
    return w.controller!.text;
  } else if (w is Text) {
    return (w.data.toString());
  }
  throw Exception('Unknown type of text field');
}
