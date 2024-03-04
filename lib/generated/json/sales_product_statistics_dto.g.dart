import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:decimal/decimal.dart';


SalesProductStatisticsDTO $SalesProductStatisticsDTOFromJson(
    Map<String, dynamic> json) {
  final SalesProductStatisticsDTO salesProductStatisticsDTO = SalesProductStatisticsDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    salesProductStatisticsDTO.ledgerId = ledgerId;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    salesProductStatisticsDTO.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    salesProductStatisticsDTO.productName = productName;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    salesProductStatisticsDTO.unitType = unitType;
  }
  final int? unitGroupId = jsonConvert.convert<int>(json['unitGroupId']);
  if (unitGroupId != null) {
    salesProductStatisticsDTO.unitGroupId = unitGroupId;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    salesProductStatisticsDTO.unitId = unitId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    salesProductStatisticsDTO.unitName = unitName;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    salesProductStatisticsDTO.masterUnitId = masterUnitId;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    salesProductStatisticsDTO.masterUnitName = masterUnitName;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    salesProductStatisticsDTO.slaveUnitId = slaveUnitId;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    salesProductStatisticsDTO.slaveUnitName = slaveUnitName;
  }
  final Decimal? number = jsonConvert.convert<Decimal>(json['number']);
  if (number != null) {
    salesProductStatisticsDTO.number = number;
  }
  final Decimal? masterNumber = jsonConvert.convert<Decimal>(
      json['masterNumber']);
  if (masterNumber != null) {
    salesProductStatisticsDTO.masterNumber = masterNumber;
  }
  final Decimal? slaveNumber = jsonConvert.convert<Decimal>(
      json['slaveNumber']);
  if (slaveNumber != null) {
    salesProductStatisticsDTO.slaveNumber = slaveNumber;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    salesProductStatisticsDTO.totalAmount = totalAmount;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    salesProductStatisticsDTO.creditAmount = creditAmount;
  }
  final Decimal? discountAmount = jsonConvert.convert<Decimal>(
      json['discountAmount']);
  if (discountAmount != null) {
    salesProductStatisticsDTO.discountAmount = discountAmount;
  }
  return salesProductStatisticsDTO;
}

Map<String, dynamic> $SalesProductStatisticsDTOToJson(
    SalesProductStatisticsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['unitType'] = entity.unitType;
  data['unitGroupId'] = entity.unitGroupId;
  data['unitId'] = entity.unitId;
  data['unitName'] = entity.unitName;
  data['masterUnitId'] = entity.masterUnitId;
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveUnitId'] = entity.slaveUnitId;
  data['slaveUnitName'] = entity.slaveUnitName;
  data['number'] = entity.number?.toJson();
  data['masterNumber'] = entity.masterNumber?.toJson();
  data['slaveNumber'] = entity.slaveNumber?.toJson();
  data['totalAmount'] = entity.totalAmount?.toJson();
  data['creditAmount'] = entity.creditAmount?.toJson();
  data['discountAmount'] = entity.discountAmount?.toJson();
  return data;
}

extension SalesProductStatisticsDTOExtension on SalesProductStatisticsDTO {
  SalesProductStatisticsDTO copyWith({
    int? ledgerId,
    int? productId,
    String? productName,
    int? unitType,
    int? unitGroupId,
    int? unitId,
    String? unitName,
    int? masterUnitId,
    String? masterUnitName,
    int? slaveUnitId,
    String? slaveUnitName,
    Decimal? number,
    Decimal? masterNumber,
    Decimal? slaveNumber,
    Decimal? totalAmount,
    Decimal? creditAmount,
    Decimal? discountAmount,
  }) {
    return SalesProductStatisticsDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..unitType = unitType ?? this.unitType
      ..unitGroupId = unitGroupId ?? this.unitGroupId
      ..unitId = unitId ?? this.unitId
      ..unitName = unitName ?? this.unitName
      ..masterUnitId = masterUnitId ?? this.masterUnitId
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveUnitId = slaveUnitId ?? this.slaveUnitId
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName
      ..number = number ?? this.number
      ..masterNumber = masterNumber ?? this.masterNumber
      ..slaveNumber = slaveNumber ?? this.slaveNumber
      ..totalAmount = totalAmount ?? this.totalAmount
      ..creditAmount = creditAmount ?? this.creditAmount
      ..discountAmount = discountAmount ?? this.discountAmount;
  }
}