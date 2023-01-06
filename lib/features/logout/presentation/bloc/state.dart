import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LogoutState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {}
