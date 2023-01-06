import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entity.dart';
import '../../domain/use_cases/login.dart';
import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCaseLogin _login;

  /// TODO: Testdaten entfernen: LoginEntity.empty()
  LoginBloc(this._login) : super(const LoginDefault(LoginEntity(pNumber: '123456', password: 'test123'))) {
    on<LoginSubmitButtonPressed>(_onSubmitButtonPressed);
  }

  Future<void> _onSubmitButtonPressed(LoginSubmitButtonPressed event, Emitter<LoginState> emit) async {
    final result = await _login(event.entity);

    result.fold(
      (error) => emit(LoginError(event.entity, error)),
      (data) => emit(LoginSuccess(event.entity)),
    );
  }
}
