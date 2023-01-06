import '../../../../core/api/client.dart';
import '../../domain/entities/entity.dart';

class CounterModel extends CounterEntity {
  const CounterModel({
    required super.id,
    required super.keyname,
    required super.value,
  });

  CounterModel.fromJson(Json json)
      : this(
          id: json['id'],
          keyname: json['keyname'],
          value: json['value'],
        );

  Json toJson() => {
        'id': id,
        'keyname': keyname,
        'value': value,
      };

  CounterModel.fromEntity(CounterEntity entity)
      : this(
          id: entity.id,
          keyname: entity.keyname,
          value: entity.value,
        );
}
