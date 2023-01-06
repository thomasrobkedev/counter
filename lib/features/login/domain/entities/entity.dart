import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String pNumber;
  final String password;

  const LoginEntity({required this.pNumber, required this.password});
  const LoginEntity.empty() : this(pNumber: '', password: '');

  @override
  List<Object> get props => [pNumber, password];
}
