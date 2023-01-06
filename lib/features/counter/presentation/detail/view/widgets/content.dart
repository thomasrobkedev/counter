import 'package:flutter/material.dart';

import '../../../../../../core/enums/testkey.dart';
import '../../../../domain/entities/entity.dart';
import '../../bloc/bloc.dart';
import '../../bloc/event.dart';
import '../widgets/button.dart';

class CounterDetailContentWidget extends StatelessWidget {
  const CounterDetailContentWidget(
    this.bloc,
    this.entity, {
    super.key,
  });

  final CounterDetailBloc bloc;
  final CounterEntity entity;

  void triggerEvent(BuildContext context, CounterDetailEvent event) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    bloc.add(event);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Card(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      key: ValueKey(Testkey.counterDetail_value.toString()),
                      entity.value.toString(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                CounterDetailButtonWidget(
                  testKey: ValueKey(Testkey.counterDetail_buttonPlus.toString()),
                  icon: Icons.add,
                  onPressed: () => triggerEvent(context, CounterDetailIncrementButtonsPressed(entity)),
                ),
                CounterDetailButtonWidget(
                  testKey: ValueKey(Testkey.counterDetail_buttonMinus.toString()),
                  icon: Icons.remove,
                  onPressed: () => triggerEvent(context, CounterDetailDecrementButtonPressed(entity)),
                ),
                CounterDetailButtonWidget(
                  testKey: ValueKey(Testkey.counterDetail_buttonReset.toString()),
                  icon: Icons.restart_alt,
                  onPressed: () => triggerEvent(context, CounterDetailResetButtonPressed(entity)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
