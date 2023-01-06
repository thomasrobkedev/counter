import 'package:equatable/equatable.dart';

abstract class CounterListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CounterListLoaded extends CounterListEvent {}

class CounterListReset extends CounterListEvent {}
