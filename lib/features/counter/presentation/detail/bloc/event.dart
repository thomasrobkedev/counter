import 'package:equatable/equatable.dart';

import '../../../domain/entities/entity.dart';

abstract class CounterDetailEvent extends Equatable {
  final CounterEntity entity;
  const CounterDetailEvent(this.entity);

  @override
  List<Object> get props => [entity];
}

class CounterDetailLoaded extends CounterDetailEvent {
  const CounterDetailLoaded(super.entity);
}

class CounterDetailIncrementButtonsPressed extends CounterDetailEvent {
  const CounterDetailIncrementButtonsPressed(super.entity);
}

class CounterDetailDecrementButtonPressed extends CounterDetailEvent {
  const CounterDetailDecrementButtonPressed(super.entity);
}

class CounterDetailResetButtonPressed extends CounterDetailEvent {
  const CounterDetailResetButtonPressed(super.entity);
}

class CounterDetailPopupMenuDeletePressed extends CounterDetailEvent {
  const CounterDetailPopupMenuDeletePressed(super.entity);
}
