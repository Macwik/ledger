import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_add_stock_car_dto.dart';
import 'package:decimal/decimal.dart';


ProductAddStockCarDTO $ProductAddStockCarDTOFromJson(
    Map<String, dynamic> json) {
  final ProductAddStockCarDTO productAddStockCarDTO = ProductAddStockCarDTO();
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    productAddStockCarDTO.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    productAddStockCarDTO.productName = productName;
  }
  final String? productStandard = jsonConvert.convert<String>(
      json['productStandard']);
  if (productStandard != null) {
    productAddStockCarDTO.productStandard = productStandard;
  }
  final String? productPlace = jsonConvert.convert<String>(
      json['productPlace']);
  if (productPlace != null) {
    productAddStockCarDTO.productPlace = productPlace;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    productAddStockCarDTO.unitType = unitType;
  }
  final int? unitGroupId = jsonConvert.convert<int>(json['unitGroupId']);
  if (unitGroupId != null) {
    productAddStockCarDTO.unitGroupId = unitGroupId;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    productAddStockCarDTO.unitId = unitId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    productAddStockCarDTO.unitName = unitName;
  }
  final bool? selectMasterUnit = jsonConvert.convert<bool>(
      json['selectMasterUnit']);
  if (selectMasterUnit != null) {
    productAddStockCarDTO.selectMasterUnit = selectMasterUnit;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    productAddStockCarDTO.masterUnitId = masterUnitId;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    productAddStockCarDTO.masterUnitName = masterUnitName;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    productAddStockCarDTO.slaveUnitId = slaveUnitId;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    productAddStockCarDTO.slaveUnitName = slaveUnitName;
  }
  final Decimal? number = jsonConvert.convert<Decimal>(json['number']);
  if (number != null) {
    productAddStockCarDTO.number = number;
  }
  final Decimal? masterNumber = jsonConvert.convert<Decimal>(
      json['masterNumber']);
  if (masterNumber != null) {
    productAddStockCarDTO.masterNumber = masterNumber;
  }
  final Decimal? slaveNumber = jsonConvert.convert<Decimal>(
      json['slaveNumber']);
  if (slaveNumber != null) {
    productAddStockCarDTO.slaveNumber = slaveNumber;
  }
  final Decimal? conversion = jsonConvert.convert<Decimal>(json['conversion']);
  if (conversion != null) {
    productAddStockCarDTO.conversion = conversion;
  }
  return productAddStockCarDTO;
}

Map<String, dynamic> $ProductAddStockCarDTOToJson(
    ProductAddStockCarDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['productStandard'] = entity.productStandard;
  data['productPlace'] = entity.productPlace;
  data['unitType'] = entity.unitType;
  data['unitGroupId'] = entity.unitGroupId;
  data['unitId'] = entity.unitId;
  data['unitName'] = entity.unitName;
  data['selectMasterUnit'] = entity.selectMasterUnit;
  data['masterUnitId'] = entity.masterUnitId;
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveUnitId'] = entity.slaveUnitId;
  data['slaveUnitName'] = entity.slaveUnitName;
  data['number'] = entity.number?.toJson();
  data['masterNumber'] = entity.masterNumber?.toJson();
  data['slaveNumber'] = entity.slaveNumber?.toJson();
  data['conversion'] = entity.conversion?.toJson();
  return data;
}

extension ProductAddStockCarDTOExtension on ProductAddStockCarDTO {
  ProductAddStockCarDTO copyWith({
    int? productId,
    String? productName,
    String? productStandard,
    String? productPlace,
    int? unitType,
    int? unitGroupId,
    int? unitId,
    String? unitName,
    bool? selectMasterUnit,
    int? masterUnitId,
    String? masterUnitName,
    int? slaveUnitId,
    String? slaveUnitName,
    Decimal? number,
    Decimal? masterNumber,
    Decimal? slaveNumber,
    Decimal? conversion,
  }) {
    return ProductAddStockCarDTO()
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..productStandard = productStandard ?? this.productStandard
      ..productPlace = productPlace ?? this.productPlace
      ..unitType = unitType ?? this.unitType
      ..unitGroupId = unitGroupId ?? this.unitGroupId
      ..unitId = unitId ?? this.unitId
      ..unitName = unitName ?? this.unitName
      ..selectMasterUnit = selectMasterUnit ?? this.selectMasterUnit
      ..masterUnitId = masterUnitId ?? this.masterUnitId
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveUnitId = slaveUnitId ?? this.slaveUnitId
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName
      ..number = number ?? this.number
      ..masterNumber = masterNumber ?? this.masterNumber
      ..slaveNumber = slaveNumber ?? this.slaveNumber
      ..conversion = conversion ?? this.conversion;
  }
}