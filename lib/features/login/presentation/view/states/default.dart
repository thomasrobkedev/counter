import 'package:flutter/material.dart';

import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../widgets/content.dart';

class LoginDefaultState extends StatelessWidget {
  final LoginBloc bloc;
  final LoginDefault state;

  const LoginDefaultState(
    this.bloc,
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LoginContentWidget(bloc, state.entity),
    );
  }
}
