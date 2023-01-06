import 'package:flutter/material.dart';

import '../../../../../core/utils/translations.dart';
import '../../../../../core/widgets/banner/banner.dart';
import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../widgets/content.dart';

class LoginErrorState extends StatelessWidget {
  final LoginBloc bloc;
  final LoginError state;

  const LoginErrorState(
    this.bloc,
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBanner.error(
            state.error.code == 401 //
                ? T()().login__authorizationError
                : T()().general__generalError,
          ),
          LoginContentWidget(bloc, state.entity),
        ],
      ),
    );
  }
}
