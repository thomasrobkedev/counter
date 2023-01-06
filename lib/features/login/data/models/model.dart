import '../../../../core/api/client.dart';
import '../../domain/entities/entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.pNumber,
    required super.password,
  });

  LoginModel.fromJson(Json json)
      : this(
          pNumber: json['pNumber'],
          password: json['password'],
        );

  Json toJson() => {
        'pNumber': pNumber,
        'password': password,
      };

  LoginModel.fromEntity(LoginEntity entity)
      : this(
          pNumber: entity.pNumber,
          password: entity.password,
        );
}
