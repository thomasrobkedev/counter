import 'package:equatable/equatable.dart';

import '../../../../core/utils/translations.dart';

class CounterEntity extends Equatable {
  final int id;
  final int index;
  final String keyname;
  final int value;

  const CounterEntity({
    required this.id,
    required this.index,
    required this.keyname,
    required this.value,
  });
  const CounterEntity.empty() : this(id: 0, index: 0, keyname: '', value: 0);

  CounterEntity copyWith({
    int? id,
    int? index,
    String? keyname,
    int? value,
  }) {
    return CounterEntity(
      id: id ?? this.id,
      index: index ?? this.index,
      keyname: keyname ?? this.keyname,
      value: value ?? this.value,
    );
  }

  @override
  List<Object> get props => [id, index, keyname, value];

  String get name => T().getByKeyname(keyname);
}
