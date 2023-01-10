import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/enums/testkey.dart';
import '../../../../../../core/routing/routing.dart';
import '../../../../../../core/utils/translations.dart';
import '../../../../domain/entities/entity.dart';

class CounterListReorderWidget extends StatefulWidget {
  final List<CounterEntity> entities;
  final Function(List<CounterEntity>) callback;

  const CounterListReorderWidget({
    required this.entities,
    required this.callback,
    super.key,
  });

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    context.push(AppRouting.routeFullscreenDialog, extra: this);
  }

  @override
  State<CounterListReorderWidget> createState() => _CounterListReorderWidgetState();
}

class _CounterListReorderWidgetState extends State<CounterListReorderWidget> {
  late List<CounterEntity> entities;

  @override
  void initState() {
    entities = widget.entities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    entities.sort((a, b) => a.index.compareTo(b.index));

    return Scaffold(
      key: ValueKey(Testkey.counterList_reorder.toString()),
      appBar: AppBar(
        title: Text(T()().counter__sequence),
        actions: [
          TextButton(
            child: Text(T()().general__save),
            onPressed: () {
              widget.callback(entities);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: false,
        padding: const EdgeInsets.all(12),
        onReorder: (oldIndex, newIndex) {
          newIndex -= oldIndex < newIndex ? 1 : 0;
          entities.insert(newIndex, entities.removeAt(oldIndex));
          entities = entities.asMap().entries.map((entry) => entry.value.copyWith(index: entry.key)).toList();
          setState(() {});
        },
        children: entities.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final entity = entry.value;

            return ReorderableDragStartListener(
              key: ValueKey(index),
              index: index,
              child: Card(
                margin: const EdgeInsets.all(4),
                child: ListTile(
                  key: ValueKey(Testkey.counterList_reorder.appendWithUnderscore(entity.id).toString()),
                  minLeadingWidth: 8,
                  leading: Text(
                    '${index + 1}.',
                    key: ValueKey(Testkey.counterList_reorder.appendWithUnderscore('${entity.id}_position')),
                  ),
                  title: Row(
                    children: [
                      Text('${T().getByKeyname(entity.keyname)} ('),
                      Text(entity.value.toString()),
                      const Text(')'),
                    ],
                  ),
                  trailing: const Icon(Icons.drag_handle),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
