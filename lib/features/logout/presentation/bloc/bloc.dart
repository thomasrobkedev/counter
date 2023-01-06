import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/delete_token.dart';
import 'event.dart';
import 'state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUseCaseDeleteToken _deleteToken;

  LogoutBloc(this._deleteToken) : super(LogoutLoading()) {
    on<LogoutLoaded>(_onLoaded);
    _deleteToken();
    add(LogoutLoaded());
  }

  Future<void> _onLoaded(LogoutLoaded event, Emitter<LogoutState> emit) async {
    emit(LogoutSuccess());
  }
}
