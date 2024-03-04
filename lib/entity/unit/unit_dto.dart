import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/unit_dto.g.dart';
import 'dart:convert';

@JsonSerializable()
class UnitDTO {
  int? id;
  int? ledgerId;
  String? unitName;
  int? unitType;

  UnitDTO();

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

  factory UnitDTO.fromJson(Map<String, dynamic> json) => $UnitDTOFromJson(json);

  Map<String, dynamic> toJson() => $UnitDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
