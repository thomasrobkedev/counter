import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/errors.dart';
import '../../../domain/entities/entity.dart';
import '../../../domain/use_cases/decrement.dart';
import '../../../domain/use_cases/delete.dart';
import '../../../domain/use_cases/get_counter.dart';
import '../../../domain/use_cases/increment.dart';
import '../../../domain/use_cases/reset.dart';
import 'event.dart';
import 'state.dart';

class CounterDetailBloc extends Bloc<CounterDetailEvent, CounterDetailState> {
  final CounterUseCaseGetCounter _getCounter;
  final CounterUseCaseIncrement _increment;
  final CounterUseCaseDecrement _decrement;
  final CounterUseCaseReset _reset;
  final CounterUseCaseDelete _delete;

  CounterDetailBloc(this._getCounter, this._increment, this._decrement, this._reset, this._delete) : super(const CounterDetailLoading(CounterEntity.empty())) {
    on<CounterDetailLoaded>(_onLoaded);
    on<CounterDetailIncrementButtonsPressed>(_onIncrement);
    on<CounterDetailDecrementButtonPressed>(_onDecrement);
    on<CounterDetailResetButtonPressed>(_onReset);
    on<CounterDetailPopupMenuDeletePressed>(_onDelete);
  }

  Future<void> _onLoaded(CounterDetailLoaded event, Emitter<CounterDetailState> emit) async {
    _emit(emit, await _getCounter(event.id), const CounterEntity.empty());
  }

  Future<void> _onIncrement(CounterDetailIncrementButtonsPressed event, Emitter<CounterDetailState> emit) async {
    _emit(emit, await _increment(event.entity), event.entity);
  }

  Future<void> _onDecrement(CounterDetailDecrementButtonPressed event, Emitter<CounterDetailState> emit) async {
    _emit(emit, await _decrement(event.entity), event.entity);
  }

  Future<void> _onReset(CounterDetailResetButtonPressed event, Emitter<CounterDetailState> emit) async {
    _emit(emit, await _reset(event.entity), event.entity);
  }

  Future<void> _onDelete(CounterDetailPopupMenuDeletePressed event, Emitter<CounterDetailState> emit) async {
    final result = await _delete(event.entity);

    result.fold(
      (error) => emit(CounterDetailError(event.entity, error)),
      (_) => emit(CounterDetailDeleteSuccess(event.entity)),
    );
  }

  void _emit(Emitter<CounterDetailState> emit, Either<AppError, CounterEntity> result, CounterEntity errorEntity) {
    result.fold(
      (error) => emit(CounterDetailError(errorEntity, error)),
      (data) => emit(CounterDetailDefault(data)),
    );
  }
}
