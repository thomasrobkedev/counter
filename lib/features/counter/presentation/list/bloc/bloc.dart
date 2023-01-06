import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_counters.dart';
import '../../../domain/use_cases/reset_database_table.dart';
import 'event.dart';
import 'state.dart';

class CounterListBloc extends Bloc<CounterListEvent, CounterListState> {
  final CounterUseCaseGetCounters _getCounters;
  final CounterUseCaseResetDatabaseTable _resetDatabaseTable;

  CounterListBloc(this._getCounters, this._resetDatabaseTable) : super(const CounterListLoading([])) {
    on<CounterListLoaded>(_onLoaded);
    on<CounterListReset>(_onReset);

    add(CounterListLoaded());
  }

  Future<void> _onLoaded(CounterListLoaded event, Emitter<CounterListState> emit) async {
    final result = await _getCounters();

    result.fold(
      (error) => emit(CounterListError(const [], error)),
      (data) => emit(CounterListDefault(data)),
    );
  }

  Future<void> _onReset(CounterListReset event, Emitter<CounterListState> emit) async {
    final result = await _resetDatabaseTable();

    result.fold(
      (error) => emit(CounterListError(const [], error)),
      (data) => emit(CounterListDefault(data)),
    );
  }
}
