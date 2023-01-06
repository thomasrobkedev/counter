import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/errors.dart';
import '../../domain/entities/entity.dart';

@immutable
abstract class LoginState extends Equatable {
  final LoginEntity entity;
  const LoginState(this.entity);

  @override
  List<Object> get props => [entity];
}

class LoginDefault extends LoginState {
  const LoginDefault(super.entity);
}

class LoginSuccess extends LoginState {
  const LoginSuccess(super.entity);
}

class LoginError extends LoginState {
  final AppError error;
  const LoginError(super.entity, this.error);

  @override
  List<Object> get props => [entity, error, DateTime.now()];
}
