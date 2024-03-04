import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/unit_detail_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class UnitDetailDTO {
  int? unitType;
  int? unitGroupId;
  int? unitId;
  String? unitName;
  bool? selectMasterUnit;
  int? masterUnitId;
  String? masterUnitName;
  int? slaveUnitId;
  String? slaveUnitName;
  Decimal? price;
  Decimal? masterPrice;
  Decimal? slavePrice;
  Decimal? number;
  Decimal? masterNumber;
  Decimal? slaveNumber;
  Decimal? stock;
  Decimal? masterStock;
  Decimal? slaveStock;
  Decimal? totalAmount;
  Decimal? conversion;

  UnitDetailDTO({
    this.unitType,
    this.unitGroupId,
    this.unitId,
    this.unitName,
    this.masterUnitId,
    this.masterUnitName,
    this.slaveUnitId,
    this.slaveUnitName,
    this.price,
    this.masterPrice,
    this.slavePrice,
    this.stock,
    this.masterStock,
    this.slaveStock,
    this.totalAmount,
    this.conversion,
  });

  factory UnitDetailDTO.fromJson(Map<String, dynamic> json) =>
      $UnitDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $UnitDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

extension UnitDetailDTOExtension on UnitDetailDTO {
  UnitDetailDTO copyWith({
    int? unitType,
    int? unitGroupId,
    int? unitId,
    String? unitName,
    bool? selectMasterUnit,
    int? masterUnitId,
    String? masterUnitName,
    int? slaveUnitId,
    String? slaveUnitName,
    Decimal? price,
    Decimal? masterPrice,
    Decimal? slavePrice,
    Decimal? number,
    Decimal? masterNumber,
    Decimal? slaveNumber,
    Decimal? stock,
    Decimal? masterStock,
    Decimal? slaveStock,
    Decimal? totalAmount,
    Decimal? conversion,
  }) {
    return UnitDetailDTO()
      ..unitType = unitType ?? this.unitType
      ..unitGroupId = unitGroupId ?? this.unitGroupId
      ..unitId = unitId ?? this.unitId
      ..unitName = unitName ?? this.unitName
      ..selectMasterUnit = selectMasterUnit ?? this.selectMasterUnit
      ..masterUnitId = masterUnitId ?? this.masterUnitId
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveUnitId = slaveUnitId ?? this.slaveUnitId
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName
      ..price = price ?? this.price
      ..masterPrice = masterPrice ?? this.masterPrice
      ..slavePrice = slavePrice ?? this.slavePrice
      ..number = number ?? this.number
      ..masterNumber = masterNumber ?? this.masterNumber
      ..slaveNumber = slaveNumber ?? this.slaveNumber
      ..stock = stock ?? this.stock
      ..masterStock = masterStock ?? this.masterStock
      ..slaveStock = slaveStock ?? this.slaveStock
      ..totalAmount = totalAmount ?? this.totalAmount
      ..conversion = conversion ?? this.conversion;
  }
}
