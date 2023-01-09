import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/errors.dart';
import '../../../domain/entities/entity.dart';
import '../../../domain/use_cases/get_counters.dart';
import '../../../domain/use_cases/reset_database_table.dart';
import '../../../domain/use_cases/set_counters.dart';
import 'event.dart';
import 'state.dart';

class CounterListBloc extends Bloc<CounterListEvent, CounterListState> {
  final CounterUseCaseGetCounters _getCounters;
  final CounterUseCaseSetCounters _setCounters;
  final CounterUseCaseResetDatabaseTable _resetDatabaseTable;

  CounterListBloc(this._getCounters, this._setCounters, this._resetDatabaseTable) : super(const CounterListLoading([])) {
    on<CounterListLoaded>(_onLoaded);
    on<CounterListUpdate>(_onUpdate);
    on<CounterListReset>(_onReset);

    add(CounterListLoaded());
  }

  Future<void> _onLoaded(CounterListLoaded event, Emitter<CounterListState> emit) async {
    _emit(emit, await _getCounters());
  }

  Future<void> _onUpdate(CounterListUpdate event, Emitter<CounterListState> emit) async {
    _emit(emit, await _setCounters(event.entities));
  }

  Future<void> _onReset(CounterListReset event, Emitter<CounterListState> emit) async {
    _emit(emit, await _resetDatabaseTable());
  }

  void _emit(Emitter<CounterListState> emit, Either<AppError, List<CounterEntity>> result) {
    result.fold(
      (error) => emit(CounterListError(const [], error)),
      (data) => emit(CounterListDefault(data)),
    );
  }
}
