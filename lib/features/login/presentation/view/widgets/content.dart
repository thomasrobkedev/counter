import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/enums/testkey.dart';
import '../../../../../core/utils/translations.dart';
import '../../../../../core/widgets/button/filled.dart';
import '../../../domain/entities/entity.dart';
import '../../bloc/bloc.dart';
import '../../bloc/event.dart';

class LoginContentWidget extends StatefulWidget {
  final LoginBloc bloc;
  final LoginEntity entity;

  const LoginContentWidget(
    this.bloc,
    this.entity, {
    super.key,
  });

  @override
  State<LoginContentWidget> createState() => _LoginContentWidgetState();
}

class _LoginContentWidgetState extends State<LoginContentWidget> {
  bool passwordVisible = false;
  late TextEditingController pNumberController;
  late TextEditingController passwordController;

  void _submit() {
    widget.bloc.add(
      LoginSubmitButtonPressed(
        LoginEntity(
          pNumber: pNumberController.text,
          password: passwordController.text,
        ),
      ),
    );
  }

  @override
  void initState() {
    pNumberController = TextEditingController(text: widget.entity.pNumber);
    passwordController = TextEditingController(text: widget.entity.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              key: ValueKey(Testkey.login_pNumber.toString()),
              controller: pNumberController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: InputDecoration(
                labelText: T()().personalNumber__title,
                prefix: const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Text('p'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              key: ValueKey(Testkey.login_password.toString()),
              controller: passwordController,
              obscureText: !passwordVisible,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: T()().general__password,
                suffix: GestureDetector(
                  child: Icon(passwordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
                  onTap: () => setState(() => passwordVisible = !passwordVisible),
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppFilledButton(
              key: ValueKey(Testkey.login_submitButton.toString()),
              onPressed: _submit,
              child: Text(T()().general__submit),
            ),
          ],
        ),
      ),
    );
  }
}
