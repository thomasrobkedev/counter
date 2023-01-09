import 'package:equatable/equatable.dart';

import '../../../domain/entities/entity.dart';

abstract class CounterListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CounterListLoaded extends CounterListEvent {}

class CounterListReset extends CounterListEvent {}

class CounterListUpdate extends CounterListEvent {
  final List<CounterEntity> entities;
  CounterListUpdate(this.entities);

  @override
  List<Object> get props => [entities];
}
