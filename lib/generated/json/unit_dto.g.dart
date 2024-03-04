import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/unit/unit_dto.dart';

UnitDTO $UnitDTOFromJson(Map<String, dynamic> json) {
  final UnitDTO unitDTO = UnitDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    unitDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    unitDTO.ledgerId = ledgerId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    unitDTO.unitName = unitName;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    unitDTO.unitType = unitType;
  }
  return unitDTO;
}

Map<String, dynamic> $UnitDTOToJson(UnitDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['unitName'] = entity.unitName;
  data['unitType'] = entity.unitType;
  return data;
}

extension UnitDTOExtension on UnitDTO {
  UnitDTO copyWith({
    int? id,
    int? ledgerId,
    String? unitName,
    int? unitType,
  }) {
    return UnitDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..unitName = unitName ?? this.unitName
      ..unitType = unitType ?? this.unitType;
  }
}