import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_sales_statistics_dto.dart';
import 'package:decimal/decimal.dart';


ProductSalesStatisticsDTO $ProductSalesStatisticsDTOFromJson(
    Map<String, dynamic> json) {
  final ProductSalesStatisticsDTO productSalesStatisticsDTO = ProductSalesStatisticsDTO();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    productSalesStatisticsDTO.id = id;
  }
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    productSalesStatisticsDTO.ledgerId = ledgerId;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    productSalesStatisticsDTO.unitType = unitType;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    productSalesStatisticsDTO.unitId = unitId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    productSalesStatisticsDTO.unitName = unitName;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    productSalesStatisticsDTO.masterUnitId = masterUnitId;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    productSalesStatisticsDTO.masterUnitName = masterUnitName;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    productSalesStatisticsDTO.slaveUnitId = slaveUnitId;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    productSalesStatisticsDTO.slaveUnitName = slaveUnitName;
  }
  final Decimal? salesNumber = jsonConvert.convert<Decimal>(
      json['salesNumber']);
  if (salesNumber != null) {
    productSalesStatisticsDTO.salesNumber = salesNumber;
  }
  final Decimal? salesMasterNumber = jsonConvert.convert<Decimal>(
      json['salesMasterNumber']);
  if (salesMasterNumber != null) {
    productSalesStatisticsDTO.salesMasterNumber = salesMasterNumber;
  }
  final Decimal? salesSlaveNumber = jsonConvert.convert<Decimal>(
      json['salesSlaveNumber']);
  if (salesSlaveNumber != null) {
    productSalesStatisticsDTO.salesSlaveNumber = salesSlaveNumber;
  }
  final Decimal? purchaseNumber = jsonConvert.convert<Decimal>(
      json['purchaseNumber']);
  if (purchaseNumber != null) {
    productSalesStatisticsDTO.purchaseNumber = purchaseNumber;
  }
  final Decimal? purchaseMasterNumber = jsonConvert.convert<Decimal>(
      json['purchaseMasterNumber']);
  if (purchaseMasterNumber != null) {
    productSalesStatisticsDTO.purchaseMasterNumber = purchaseMasterNumber;
  }
  final Decimal? purchaseSlaveNumber = jsonConvert.convert<Decimal>(
      json['purchaseSlaveNumber']);
  if (purchaseSlaveNumber != null) {
    productSalesStatisticsDTO.purchaseSlaveNumber = purchaseSlaveNumber;
  }
  final Decimal? addStoreNumber = jsonConvert.convert<Decimal>(
      json['addStoreNumber']);
  if (addStoreNumber != null) {
    productSalesStatisticsDTO.addStoreNumber = addStoreNumber;
  }
  final Decimal? addStoreMasterNumber = jsonConvert.convert<Decimal>(
      json['addStoreMasterNumber']);
  if (addStoreMasterNumber != null) {
    productSalesStatisticsDTO.addStoreMasterNumber = addStoreMasterNumber;
  }
  final Decimal? addStoreSlaveNumber = jsonConvert.convert<Decimal>(
      json['addStoreSlaveNumber']);
  if (addStoreSlaveNumber != null) {
    productSalesStatisticsDTO.addStoreSlaveNumber = addStoreSlaveNumber;
  }
  final Decimal? salesTotalAmount = jsonConvert.convert<Decimal>(
      json['salesTotalAmount']);
  if (salesTotalAmount != null) {
    productSalesStatisticsDTO.salesTotalAmount = salesTotalAmount;
  }
  final Decimal? salesDiscountAmount = jsonConvert.convert<Decimal>(
      json['salesDiscountAmount']);
  if (salesDiscountAmount != null) {
    productSalesStatisticsDTO.salesDiscountAmount = salesDiscountAmount;
  }
  final Decimal? salesRepaymentDiscountAmount = jsonConvert.convert<Decimal>(
      json['salesRepaymentDiscountAmount']);
  if (salesRepaymentDiscountAmount != null) {
    productSalesStatisticsDTO.salesRepaymentDiscountAmount =
        salesRepaymentDiscountAmount;
  }
  final Decimal? salesCreditAmount = jsonConvert.convert<Decimal>(
      json['salesCreditAmount']);
  if (salesCreditAmount != null) {
    productSalesStatisticsDTO.salesCreditAmount = salesCreditAmount;
  }
  final Decimal? purchaseTotalAmount = jsonConvert.convert<Decimal>(
      json['purchaseTotalAmount']);
  if (purchaseTotalAmount != null) {
    productSalesStatisticsDTO.purchaseTotalAmount = purchaseTotalAmount;
  }
  final Decimal? purchaseDiscountAmount = jsonConvert.convert<Decimal>(
      json['purchaseDiscountAmount']);
  if (purchaseDiscountAmount != null) {
    productSalesStatisticsDTO.purchaseDiscountAmount = purchaseDiscountAmount;
  }
  final Decimal? purchaseRepaymentDiscountAmount = jsonConvert.convert<Decimal>(
      json['purchaseRepaymentDiscountAmount']);
  if (purchaseRepaymentDiscountAmount != null) {
    productSalesStatisticsDTO.purchaseRepaymentDiscountAmount =
        purchaseRepaymentDiscountAmount;
  }
  final Decimal? purchaseCreditAmount = jsonConvert.convert<Decimal>(
      json['purchaseCreditAmount']);
  if (purchaseCreditAmount != null) {
    productSalesStatisticsDTO.purchaseCreditAmount = purchaseCreditAmount;
  }
  final Decimal? costTotalAmount = jsonConvert.convert<Decimal>(
      json['costTotalAmount']);
  if (costTotalAmount != null) {
    productSalesStatisticsDTO.costTotalAmount = costTotalAmount;
  }
  return productSalesStatisticsDTO;
}

Map<String, dynamic> $ProductSalesStatisticsDTOToJson(
    ProductSalesStatisticsDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['ledgerId'] = entity.ledgerId;
  data['unitType'] = entity.unitType;
  data['unitId'] = entity.unitId;
  data['unitName'] = entity.unitName;
  data['masterUnitId'] = entity.masterUnitId;
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveUnitId'] = entity.slaveUnitId;
  data['slaveUnitName'] = entity.slaveUnitName;
  data['salesNumber'] = entity.salesNumber?.toJson();
  data['salesMasterNumber'] = entity.salesMasterNumber?.toJson();
  data['salesSlaveNumber'] = entity.salesSlaveNumber?.toJson();
  data['purchaseNumber'] = entity.purchaseNumber?.toJson();
  data['purchaseMasterNumber'] = entity.purchaseMasterNumber?.toJson();
  data['purchaseSlaveNumber'] = entity.purchaseSlaveNumber?.toJson();
  data['addStoreNumber'] = entity.addStoreNumber?.toJson();
  data['addStoreMasterNumber'] = entity.addStoreMasterNumber?.toJson();
  data['addStoreSlaveNumber'] = entity.addStoreSlaveNumber?.toJson();
  data['salesTotalAmount'] = entity.salesTotalAmount?.toJson();
  data['salesDiscountAmount'] = entity.salesDiscountAmount?.toJson();
  data['salesRepaymentDiscountAmount'] =
      entity.salesRepaymentDiscountAmount?.toJson();
  data['salesCreditAmount'] = entity.salesCreditAmount?.toJson();
  data['purchaseTotalAmount'] = entity.purchaseTotalAmount?.toJson();
  data['purchaseDiscountAmount'] = entity.purchaseDiscountAmount?.toJson();
  data['purchaseRepaymentDiscountAmount'] =
      entity.purchaseRepaymentDiscountAmount?.toJson();
  data['purchaseCreditAmount'] = entity.purchaseCreditAmount?.toJson();
  data['costTotalAmount'] = entity.costTotalAmount?.toJson();
  return data;
}

extension ProductSalesStatisticsDTOExtension on ProductSalesStatisticsDTO {
  ProductSalesStatisticsDTO copyWith({
    int? id,
    int? ledgerId,
    int? unitType,
    int? unitId,
    String? unitName,
    int? masterUnitId,
    String? masterUnitName,
    int? slaveUnitId,
    String? slaveUnitName,
    Decimal? salesNumber,
    Decimal? salesMasterNumber,
    Decimal? salesSlaveNumber,
    Decimal? purchaseNumber,
    Decimal? purchaseMasterNumber,
    Decimal? purchaseSlaveNumber,
    Decimal? addStoreNumber,
    Decimal? addStoreMasterNumber,
    Decimal? addStoreSlaveNumber,
    Decimal? salesTotalAmount,
    Decimal? salesDiscountAmount,
    Decimal? salesRepaymentDiscountAmount,
    Decimal? salesCreditAmount,
    Decimal? purchaseTotalAmount,
    Decimal? purchaseDiscountAmount,
    Decimal? purchaseRepaymentDiscountAmount,
    Decimal? purchaseCreditAmount,
    Decimal? costTotalAmount,
  }) {
    return ProductSalesStatisticsDTO()
      ..id = id ?? this.id
      ..ledgerId = ledgerId ?? this.ledgerId
      ..unitType = unitType ?? this.unitType
      ..unitId = unitId ?? this.unitId
      ..unitName = unitName ?? this.unitName
      ..masterUnitId = masterUnitId ?? this.masterUnitId
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveUnitId = slaveUnitId ?? this.slaveUnitId
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName
      ..salesNumber = salesNumber ?? this.salesNumber
      ..salesMasterNumber = salesMasterNumber ?? this.salesMasterNumber
      ..salesSlaveNumber = salesSlaveNumber ?? this.salesSlaveNumber
      ..purchaseNumber = purchaseNumber ?? this.purchaseNumber
      ..purchaseMasterNumber = purchaseMasterNumber ?? this.purchaseMasterNumber
      ..purchaseSlaveNumber = purchaseSlaveNumber ?? this.purchaseSlaveNumber
      ..addStoreNumber = addStoreNumber ?? this.addStoreNumber
      ..addStoreMasterNumber = addStoreMasterNumber ?? this.addStoreMasterNumber
      ..addStoreSlaveNumber = addStoreSlaveNumber ?? this.addStoreSlaveNumber
      ..salesTotalAmount = salesTotalAmount ?? this.salesTotalAmount
      ..salesDiscountAmount = salesDiscountAmount ?? this.salesDiscountAmount
      ..salesRepaymentDiscountAmount = salesRepaymentDiscountAmount ??
          this.salesRepaymentDiscountAmount
      ..salesCreditAmount = salesCreditAmount ?? this.salesCreditAmount
      ..purchaseTotalAmount = purchaseTotalAmount ?? this.purchaseTotalAmount
      ..purchaseDiscountAmount = purchaseDiscountAmount ??
          this.purchaseDiscountAmount
      ..purchaseRepaymentDiscountAmount = purchaseRepaymentDiscountAmount ??
          this.purchaseRepaymentDiscountAmount
      ..purchaseCreditAmount = purchaseCreditAmount ?? this.purchaseCreditAmount
      ..costTotalAmount = costTotalAmount ?? this.costTotalAmount;
  }
}