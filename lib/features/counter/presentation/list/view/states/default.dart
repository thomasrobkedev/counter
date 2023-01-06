import 'package:flutter/material.dart';

import '../../../../../../core/widgets/responsive/col.dart';
import '../../../../../../core/widgets/responsive/row.dart';
import '../../../../domain/entities/entity.dart';
import '../widgets/card.dart';

class CounterListDefaultState extends StatelessWidget {
  final List<CounterEntity> entities;

  const CounterListDefaultState(
    this.entities, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: AppResponsiveRow(
          children: entities
              .map(
                (item) => AppResponsiveCol(
                  xs: 1 / 2,
                  sm: 1 / 4,
                  md: 1 / 4,
                  child: CounterListCardWidget(item),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
