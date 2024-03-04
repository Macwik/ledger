import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/stock_change_record_dto.dart';
import 'package:decimal/decimal.dart';


StockChangeRecordDTO $StockChangeRecordDTOFromJson(Map<String, dynamic> json) {
  final StockChangeRecordDTO stockChangeRecordDTO = StockChangeRecordDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    stockChangeRecordDTO.ledgerId = ledgerId;
  }
  final int? userId = jsonConvert.convert<int>(json['userId']);
  if (userId != null) {
    stockChangeRecordDTO.userId = userId;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    stockChangeRecordDTO.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    stockChangeRecordDTO.productName = productName;
  }
  final int? supplier = jsonConvert.convert<int>(json['supplier']);
  if (supplier != null) {
    stockChangeRecordDTO.supplier = supplier;
  }
  final String? supplierName = jsonConvert.convert<String>(
      json['supplierName']);
  if (supplierName != null) {
    stockChangeRecordDTO.supplierName = supplierName;
  }
  final String? productStandard = jsonConvert.convert<String>(
      json['productStandard']);
  if (productStandard != null) {
    stockChangeRecordDTO.productStandard = productStandard;
  }
  final String? productPlace = jsonConvert.convert<String>(
      json['productPlace']);
  if (productPlace != null) {
    stockChangeRecordDTO.productPlace = productPlace;
  }
  final int? salesChannel = jsonConvert.convert<int>(json['salesChannel']);
  if (salesChannel != null) {
    stockChangeRecordDTO.salesChannel = salesChannel;
  }
  final String? adjustDate = jsonConvert.convert<String>(json['adjustDate']);
  if (adjustDate != null) {
    stockChangeRecordDTO.adjustDate = adjustDate;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    stockChangeRecordDTO.unitType = unitType;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    stockChangeRecordDTO.unitId = unitId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    stockChangeRecordDTO.unitName = unitName;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    stockChangeRecordDTO.masterUnitId = masterUnitId;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    stockChangeRecordDTO.masterUnitName = masterUnitName;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    stockChangeRecordDTO.slaveUnitId = slaveUnitId;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    stockChangeRecordDTO.slaveUnitName = slaveUnitName;
  }
  final Decimal? beforeStock = jsonConvert.convert<Decimal>(
      json['beforeStock']);
  if (beforeStock != null) {
    stockChangeRecordDTO.beforeStock = beforeStock;
  }
  final Decimal? beforeMasterStock = jsonConvert.convert<Decimal>(
      json['beforeMasterStock']);
  if (beforeMasterStock != null) {
    stockChangeRecordDTO.beforeMasterStock = beforeMasterStock;
  }
  final Decimal? beforeSlaveStock = jsonConvert.convert<Decimal>(
      json['beforeSlaveStock']);
  if (beforeSlaveStock != null) {
    stockChangeRecordDTO.beforeSlaveStock = beforeSlaveStock;
  }
  final Decimal? afterStock = jsonConvert.convert<Decimal>(json['afterStock']);
  if (afterStock != null) {
    stockChangeRecordDTO.afterStock = afterStock;
  }
  final Decimal? afterMasterStock = jsonConvert.convert<Decimal>(
      json['afterMasterStock']);
  if (afterMasterStock != null) {
    stockChangeRecordDTO.afterMasterStock = afterMasterStock;
  }
  final Decimal? afterSlaveStock = jsonConvert.convert<Decimal>(
      json['afterSlaveStock']);
  if (afterSlaveStock != null) {
    stockChangeRecordDTO.afterSlaveStock = afterSlaveStock;
  }
  final int? creator = jsonConvert.convert<int>(json['creator']);
  if (creator != null) {
    stockChangeRecordDTO.creator = creator;
  }
  final String? creatorName = jsonConvert.convert<String>(json['creatorName']);
  if (creatorName != null) {
    stockChangeRecordDTO.creatorName = creatorName;
  }
  return stockChangeRecordDTO;
}

Map<String, dynamic> $StockChangeRecordDTOToJson(StockChangeRecordDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['userId'] = entity.userId;
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['supplier'] = entity.supplier;
  data['supplierName'] = entity.supplierName;
  data['productStandard'] = entity.productStandard;
  data['productPlace'] = entity.productPlace;
  data['salesChannel'] = entity.salesChannel;
  data['adjustDate'] = entity.adjustDate;
  data['unitType'] = entity.unitType;
  data['unitId'] = entity.unitId;
  data['unitName'] = entity.unitName;
  data['masterUnitId'] = entity.masterUnitId;
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveUnitId'] = entity.slaveUnitId;
  data['slaveUnitName'] = entity.slaveUnitName;
  data['beforeStock'] = entity.beforeStock?.toJson();
  data['beforeMasterStock'] = entity.beforeMasterStock?.toJson();
  data['beforeSlaveStock'] = entity.beforeSlaveStock?.toJson();
  data['afterStock'] = entity.afterStock?.toJson();
  data['afterMasterStock'] = entity.afterMasterStock?.toJson();
  data['afterSlaveStock'] = entity.afterSlaveStock?.toJson();
  data['creator'] = entity.creator;
  data['creatorName'] = entity.creatorName;
  return data;
}

extension StockChangeRecordDTOExtension on StockChangeRecordDTO {
  StockChangeRecordDTO copyWith({
    int? ledgerId,
    int? userId,
    int? productId,
    String? productName,
    int? supplier,
    String? supplierName,
    String? productStandard,
    String? productPlace,
    int? salesChannel,
    String? adjustDate,
    int? unitType,
    int? unitId,
    String? unitName,
    int? masterUnitId,
    String? masterUnitName,
    int? slaveUnitId,
    String? slaveUnitName,
    Decimal? beforeStock,
    Decimal? beforeMasterStock,
    Decimal? beforeSlaveStock,
    Decimal? afterStock,
    Decimal? afterMasterStock,
    Decimal? afterSlaveStock,
    int? creator,
    String? creatorName,
  }) {
    return StockChangeRecordDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..userId = userId ?? this.userId
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..supplier = supplier ?? this.supplier
      ..supplierName = supplierName ?? this.supplierName
      ..productStandard = productStandard ?? this.productStandard
      ..productPlace = productPlace ?? this.productPlace
      ..salesChannel = salesChannel ?? this.salesChannel
      ..adjustDate = adjustDate ?? this.adjustDate
      ..unitType = unitType ?? this.unitType
      ..unitId = unitId ?? this.unitId
      ..unitName = unitName ?? this.unitName
      ..masterUnitId = masterUnitId ?? this.masterUnitId
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveUnitId = slaveUnitId ?? this.slaveUnitId
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName
      ..beforeStock = beforeStock ?? this.beforeStock
      ..beforeMasterStock = beforeMasterStock ?? this.beforeMasterStock
      ..beforeSlaveStock = beforeSlaveStock ?? this.beforeSlaveStock
      ..afterStock = afterStock ?? this.afterStock
      ..afterMasterStock = afterMasterStock ?? this.afterMasterStock
      ..afterSlaveStock = afterSlaveStock ?? this.afterSlaveStock
      ..creator = creator ?? this.creator
      ..creatorName = creatorName ?? this.creatorName;
  }
}