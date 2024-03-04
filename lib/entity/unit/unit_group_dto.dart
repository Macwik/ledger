import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/unit_group_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class UnitGroupDTO {
  int? id;
  int? ledgerId;
  int? masterUnit;
  String? masterUnitName;
  int? slaveUnit;
  String? slaveUnitName;
  Decimal? conversion;
  int? unitType;

  UnitGroupDTO({this.id,
    this.ledgerId,
    this.masterUnit,
    this.masterUnitName,
    this.slaveUnit,
    this.slaveUnitName,
    this.conversion,
    this.unitType});

  factory UnitGroupDTO.fromJson(Map<String, dynamic> json) =>
      $UnitGroupDTOFromJson(json);

  Map<String, dynamic> toJson() => $UnitGroupDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
