import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_sales_credit_dto.dart';
import 'package:decimal/decimal.dart';


ProductSalesCreditDTO $ProductSalesCreditDTOFromJson(
    Map<String, dynamic> json) {
  final ProductSalesCreditDTO productSalesCreditDTO = ProductSalesCreditDTO();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    productSalesCreditDTO.ledgerId = ledgerId;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    productSalesCreditDTO.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    productSalesCreditDTO.productName = productName;
  }
  final int? orderId = jsonConvert.convert<int>(json['orderId']);
  if (orderId != null) {
    productSalesCreditDTO.orderId = orderId;
  }
  final DateTime? gmtCreate = jsonConvert.convert<DateTime>(json['gmtCreate']);
  if (gmtCreate != null) {
    productSalesCreditDTO.gmtCreate = gmtCreate;
  }
  final DateTime? orderDate = jsonConvert.convert<DateTime>(json['orderDate']);
  if (orderDate != null) {
    productSalesCreditDTO.orderDate = orderDate;
  }
  final int? customerId = jsonConvert.convert<int>(json['customerId']);
  if (customerId != null) {
    productSalesCreditDTO.customerId = customerId;
  }
  final String? customerName = jsonConvert.convert<String>(
      json['customerName']);
  if (customerName != null) {
    productSalesCreditDTO.customerName = customerName;
  }
  final int? orderType = jsonConvert.convert<int>(json['orderType']);
  if (orderType != null) {
    productSalesCreditDTO.orderType = orderType;
  }
  final int? orderStatus = jsonConvert.convert<int>(json['orderStatus']);
  if (orderStatus != null) {
    productSalesCreditDTO.orderStatus = orderStatus;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    productSalesCreditDTO.unitType = unitType;
  }
  final int? unitId = jsonConvert.convert<int>(json['unitId']);
  if (unitId != null) {
    productSalesCreditDTO.unitId = unitId;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    productSalesCreditDTO.unitName = unitName;
  }
  final int? masterUnitId = jsonConvert.convert<int>(json['masterUnitId']);
  if (masterUnitId != null) {
    productSalesCreditDTO.masterUnitId = masterUnitId;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    productSalesCreditDTO.masterUnitName = masterUnitName;
  }
  final int? slaveUnitId = jsonConvert.convert<int>(json['slaveUnitId']);
  if (slaveUnitId != null) {
    productSalesCreditDTO.slaveUnitId = slaveUnitId;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    productSalesCreditDTO.slaveUnitName = slaveUnitName;
  }
  final Decimal? number = jsonConvert.convert<Decimal>(json['number']);
  if (number != null) {
    productSalesCreditDTO.number = number;
  }
  final Decimal? masterNumber = jsonConvert.convert<Decimal>(
      json['masterNumber']);
  if (masterNumber != null) {
    productSalesCreditDTO.masterNumber = masterNumber;
  }
  final Decimal? slaveNumber = jsonConvert.convert<Decimal>(
      json['slaveNumber']);
  if (slaveNumber != null) {
    productSalesCreditDTO.slaveNumber = slaveNumber;
  }
  final Decimal? totalAmount = jsonConvert.convert<Decimal>(
      json['totalAmount']);
  if (totalAmount != null) {
    productSalesCreditDTO.totalAmount = totalAmount;
  }
  final Decimal? creditAmount = jsonConvert.convert<Decimal>(
      json['creditAmount']);
  if (creditAmount != null) {
    productSalesCreditDTO.creditAmount = creditAmount;
  }
  final Decimal? repaymentAmount = jsonConvert.convert<Decimal>(
      json['repaymentAmount']);
  if (repaymentAmount != null) {
    productSalesCreditDTO.repaymentAmount = repaymentAmount;
  }
  return productSalesCreditDTO;
}

Map<String, dynamic> $ProductSalesCreditDTOToJson(
    ProductSalesCreditDTO entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['orderId'] = entity.orderId;
  data['gmtCreate'] = entity.gmtCreate?.toIso8601String();
  data['orderDate'] = entity.orderDate?.toIso8601String();
  data['customerId'] = entity.customerId;
  data['customerName'] = entity.customerName;
  data['orderType'] = entity.orderType;
  data['orderStatus'] = entity.orderStatus;
  data['unitType'] = entity.unitType;
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
  data['repaymentAmount'] = entity.repaymentAmount?.toJson();
  return data;
}

extension ProductSalesCreditDTOExtension on ProductSalesCreditDTO {
  ProductSalesCreditDTO copyWith({
    int? ledgerId,
    int? productId,
    String? productName,
    int? orderId,
    DateTime? gmtCreate,
    DateTime? orderDate,
    int? customerId,
    String? customerName,
    int? orderType,
    int? orderStatus,
    int? unitType,
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
    Decimal? repaymentAmount,
  }) {
    return ProductSalesCreditDTO()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..orderId = orderId ?? this.orderId
      ..gmtCreate = gmtCreate ?? this.gmtCreate
      ..orderDate = orderDate ?? this.orderDate
      ..customerId = customerId ?? this.customerId
      ..customerName = customerName ?? this.customerName
      ..orderType = orderType ?? this.orderType
      ..orderStatus = orderStatus ?? this.orderStatus
      ..unitType = unitType ?? this.unitType
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
      ..repaymentAmount = repaymentAmount ?? this.repaymentAmount;
  }
}