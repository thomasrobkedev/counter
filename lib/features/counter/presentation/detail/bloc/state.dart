import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/errors.dart';
import '../../../domain/entities/entity.dart';

@immutable
abstract class CounterDetailState extends Equatable {
  final CounterEntity entity;
  const CounterDetailState(this.entity);

  @override
  List<Object> get props => [entity];
}

class CounterDetailLoading extends CounterDetailState {
  const CounterDetailLoading(super.entity);
}

class CounterDetailDefault extends CounterDetailState {
  const CounterDetailDefault(super.entity);
}

class CounterDetailDeleteSuccess extends CounterDetailState {
  const CounterDetailDeleteSuccess(super.entity);
}

class CounterDetailError extends CounterDetailState {
  final AppError error;
  const CounterDetailError(super.entity, this.error);

  @override
  List<Object> get props => [entity, error];
}
