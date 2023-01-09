import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/errors.dart';
import '../../../domain/entities/entity.dart';

@immutable
abstract class CounterListState extends Equatable {
  final List<CounterEntity> entities;
  const CounterListState(this.entities);

  @override
  List<Object> get props => [entities];
}

class CounterListLoading extends CounterListState {
  const CounterListLoading(super.entities);
}

class CounterListDefault extends CounterListState {
  const CounterListDefault(super.entities);
}

class CounterListError extends CounterListState {
  final AppError error;
  const CounterListError(super.entities, this.error);

  @override
  List<Object> get props => [entities, error];
}
