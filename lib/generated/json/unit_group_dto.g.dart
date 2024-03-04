import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/unit/unit_group_dto.dart';
import 'package:decimal/decimal.dart';


UnitGroupDTO $UnitGroupDTOFromJson(Map<String, dynamic> json) {
  final UnitGroupDTO unitGroupDTO = UnitGroupDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    unitGroupDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    unitGroupDTO.ledgerId = ledgerId;
  }
  final int? masterUnit = jsonConvert.convert<int>(json['masterUnit']);
  if (masterUnit != null) {
    unitGroupDTO.masterUnit = masterUnit;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    unitGroupDTO.masterUnitName = masterUnitName;
  }
  final int? slaveUnit = jsonConvert.convert<int>(json['slaveUnit']);
  if (slaveUnit != null) {
    unitGroupDTO.slaveUnit = slaveUnit;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    unitGroupDTO.slaveUnitName = slaveUnitName;
  }
  final Decimal? conversion = jsonConvert.convert<Decimal>(json['conversion']);
  if (conversion != null) {
    unitGroupDTO.conversion = conversion;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    unitGroupDTO.unitType = unitType;
  }
  return unitGroupDTO;
}

Map<String, dynamic> $UnitGroupDTOToJson(UnitGroupDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['masterUnit'] = entity.masterUnit;
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveUnit'] = entity.slaveUnit;
  data['slaveUnitName'] = entity.slaveUnitName;
  data['conversion'] = entity.conversion?.toJson();
  data['unitType'] = entity.unitType;
  return data;
}

extension UnitGroupDTOExtension on UnitGroupDTO {
  UnitGroupDTO copyWith({
    int? id,
    int? ledgerId,
    int? masterUnit,
    String? masterUnitName,
    int? slaveUnit,
    String? slaveUnitName,
    Decimal? conversion,
    int? unitType,
  }) {
    return UnitGroupDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..masterUnit = masterUnit ?? this.masterUnit
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveUnit = slaveUnit ?? this.slaveUnit
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName
      ..conversion = conversion ?? this.conversion
      ..unitType = unitType ?? this.unitType;
  }
}