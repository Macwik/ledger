import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:decimal/decimal.dart';


UnitDetailDTO $UnitDetailDTOFromJson(Map<String, dynamic> json) {
  final UnitDetailDTO unitDetailDTO = UnitDetailDTO();
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    unitDetailDTO.unitType = unitType;
  }
  final int? unitGroupId = jsonConvert.convert<int>(json['unitGroupId']);
  if (unitGroupId != null) {
    unitDetailDTO.unitGroupId = unitGroupId;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    unitDetailDTO.unitId = unitId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    unitDetailDTO.unitName = unitName;
  }
  final bool? selectMasterUnit = jsonConvert.convert<bool>(
      json['selectMasterUnit']);
  if (selectMasterUnit != null) {
    unitDetailDTO.selectMasterUnit = selectMasterUnit;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    unitDetailDTO.masterUnitId = masterUnitId;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    unitDetailDTO.masterUnitName = masterUnitName;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    unitDetailDTO.slaveUnitId = slaveUnitId;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    unitDetailDTO.slaveUnitName = slaveUnitName;
  }
  final Decimal? price = jsonConvert.convert<Decimal>(json['price']);
  if (price != null) {
    unitDetailDTO.price = price;
  }
  final Decimal? masterPrice = jsonConvert.convert<Decimal>(
      json['masterPrice']);
  if (masterPrice != null) {
    unitDetailDTO.masterPrice = masterPrice;
  }
  final Decimal? slavePrice = jsonConvert.convert<Decimal>(json['slavePrice']);
  if (slavePrice != null) {
    unitDetailDTO.slavePrice = slavePrice;
  }
  final Decimal? number = jsonConvert.convert<Decimal>(json['number']);
  if (number != null) {
    unitDetailDTO.number = number;
  }
  final Decimal? masterNumber = jsonConvert.convert<Decimal>(
      json['masterNumber']);
  if (masterNumber != null) {
    unitDetailDTO.masterNumber = masterNumber;
  }
  final Decimal? slaveNumber = jsonConvert.convert<Decimal>(
      json['slaveNumber']);
  if (slaveNumber != null) {
    unitDetailDTO.slaveNumber = slaveNumber;
  }
  final Decimal? stock = jsonConvert.convert<Decimal>(json['stock']);
  if (stock != null) {
    unitDetailDTO.stock = stock;
  }
  final Decimal? masterStock = jsonConvert.convert<Decimal>(
      json['masterStock']);
  if (masterStock != null) {
    unitDetailDTO.masterStock = masterStock;
  }
  final Decimal? slaveStock = jsonConvert.convert<Decimal>(json['slaveStock']);
  if (slaveStock != null) {
    unitDetailDTO.slaveStock = slaveStock;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    unitDetailDTO.totalAmount = totalAmount;
  }
  final Decimal? conversion = jsonConvert.convert<Decimal>(json['conversion']);
  if (conversion != null) {
    unitDetailDTO.conversion = conversion;
  }
  return unitDetailDTO;
}

Map<String, dynamic> $UnitDetailDTOToJson(UnitDetailDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['unitType'] = entity.unitType;
  data['unitGroupId'] = entity.unitGroupId;
  data['unitId'] = entity.unitId;
  data['unitName'] = entity.unitName;
  data['selectMasterUnit'] = entity.selectMasterUnit;
  data['masterUnitId'] = entity.masterUnitId;
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveUnitId'] = entity.slaveUnitId;
  data['slaveUnitName'] = entity.slaveUnitName;
  data['price'] = entity.price?.toJson();
  data['masterPrice'] = entity.masterPrice?.toJson();
  data['slavePrice'] = entity.slavePrice?.toJson();
  data['number'] = entity.number?.toJson();
  data['masterNumber'] = entity.masterNumber?.toJson();
  data['slaveNumber'] = entity.slaveNumber?.toJson();
  data['stock'] = entity.stock?.toJson();
  data['masterStock'] = entity.masterStock?.toJson();
  data['slaveStock'] = entity.slaveStock?.toJson();
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['conversion'] = entity.conversion?.toJson();
  return data;
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