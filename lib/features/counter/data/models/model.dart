import '../../../../core/api/client.dart';
import '../../domain/entities/entity.dart';

class CounterModel extends CounterEntity {
  const CounterModel({
    required super.id,
    required super.index,
    required super.keyname,
    required super.value,
  });

  CounterModel.fromJson(Json json)
      : this(
          id: json['id'],
          index: json['index'],
          keyname: json['keyname'],
          value: json['value'],
        );

  Json toJson() => {
        'id': id,
        'index': index,
        'keyname': keyname,
        'value': value,
      };

  CounterModel.fromEntity(CounterEntity entity)
      : this(
          id: entity.id,
          index: entity.index,
          keyname: entity.keyname,
          value: entity.value,
        );
}
