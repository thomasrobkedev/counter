import 'package:equatable/equatable.dart';

import '../../domain/entities/entity.dart';

abstract class LoginEvent extends Equatable {
  final LoginEntity entity;
  const LoginEvent(this.entity);

  @override
  List<Object> get props => [];
}

class LoginSubmitButtonPressed extends LoginEvent {
  const LoginSubmitButtonPressed(super.entity);

  @override
  List<Object> get props => [entity, DateTime.now()];
}
