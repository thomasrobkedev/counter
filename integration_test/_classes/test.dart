import 'package:flutter_test/flutter_test.dart';

import '../functions.dart';

abstract class ItemType {}

abstract class TestWidget {
  Future<void> call() async {}
}

class Test implements ItemType {
  final int? _enabled;
  final TestWidget _testWidget;

  Test(this._enabled, this._testWidget);
}

class Group implements ItemType {
  final int? _enabled;
  final List<ItemType> _items;

  Group(this._enabled, this._items);

  void generateTestWidgets() {
    _iterate(_enabled);
  }

  void _iterate(int? enabled) {
    for (var item in _items) {
      if (item is Group) {
        item._iterate(item._enabled ?? enabled);
        continue;
      }

      if (item is Test) {
        if ((item._enabled ?? enabled ?? 1) > 0) {
          testWidgets(item._testWidget.runtimeType.toString(), (tester) async {
            await startupApp(tester);
            await item._testWidget();
          });
        }
      }
    }
  }
}
