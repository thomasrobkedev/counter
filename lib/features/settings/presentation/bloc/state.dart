import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/entity.dart';

@immutable
abstract class SettingsState extends Equatable {
  final SettingsEntity entity;
  const SettingsState(this.entity);

  @override
  List<Object> get props => [entity];
}

class SettingsLoading extends SettingsState {
  const SettingsLoading(super.entity);
}

class SettingsDefault extends SettingsState {
  const SettingsDefault(super.entity);
}

class SettingsSuccess extends SettingsState {
  const SettingsSuccess(super.entity);

  @override
  List<Object> get props => [entity, DateTime.now()];
}

class SettingsError extends SettingsState {
  final AppError error;
  const SettingsError(super.entity, this.error);

  @override
  List<Object> get props => [entity, error];
}
