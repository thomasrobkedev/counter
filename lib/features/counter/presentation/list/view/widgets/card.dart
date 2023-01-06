import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/enums/testkey.dart';
import '../../../../../../core/routing/routing.dart';
import '../../../../domain/entities/entity.dart';

class CounterListCardWidget extends StatelessWidget {
  final CounterEntity entity;

  const CounterListCardWidget(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        AppRouting.routeNameCountersDetail,
        params: {'id': entity.id.toString()},
        queryParams: {'title': entity.name},
      ),
      child: Card(
        key: ValueKey(Testkey.counterList_card.appendWithUnderscore(entity.keyname)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: Center(
                  child: Text(
                    key: ValueKey(Testkey.counterList_cardName.appendWithUnderscore(entity.keyname)),
                    entity.name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    key: ValueKey(Testkey.counterList_cardValue.appendWithUnderscore(entity.keyname)),
                    entity.value.toString(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
