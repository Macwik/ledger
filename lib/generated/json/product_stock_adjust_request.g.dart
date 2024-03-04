import 'package:ledger/generated/json/base/json_convert_content.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:decimal/decimal.dart';


ProductStockAdjustRequest $ProductStockAdjustRequestFromJson(
    Map<String, dynamic> json) {
  final ProductStockAdjustRequest productStockAdjustRequest = ProductStockAdjustRequest();
  final int? ledgerId = jsonConvert.convert<int>(json['ledgerId']);
  if (ledgerId != null) {
    productStockAdjustRequest.ledgerId = ledgerId;
  }
  final int? productId = jsonConvert.convert<int>(json['productId']);
  if (productId != null) {
    productStockAdjustRequest.productId = productId;
  }
  final String? productName = jsonConvert.convert<String>(json['productName']);
  if (productName != null) {
    productStockAdjustRequest.productName = productName;
  }
  final int? unitType = jsonConvert.convert<int>(json['unitType']);
  if (unitType != null) {
    productStockAdjustRequest.unitType = unitType;
  }
  final Decimal? stock = jsonConvert.convert<Decimal>(json['stock']);
  if (stock != null) {
    productStockAdjustRequest.stock = stock;
  }
  final String? unitName = jsonConvert.convert<String>(json['unitName']);
  if (unitName != null) {
    productStockAdjustRequest.unitName = unitName;
  }
  final Decimal? masterStock = jsonConvert.convert<Decimal>(
      json['masterStock']);
  if (masterStock != null) {
    productStockAdjustRequest.masterStock = masterStock;
  }
  final String? masterUnitName = jsonConvert.convert<String>(
      json['masterUnitName']);
  if (masterUnitName != null) {
    productStockAdjustRequest.masterUnitName = masterUnitName;
  }
  final Decimal? slaveStock = jsonConvert.convert<Decimal>(json['slaveStock']);
  if (slaveStock != null) {
    productStockAdjustRequest.slaveStock = slaveStock;
  }
  final String? slaveUnitName = jsonConvert.convert<String>(
      json['slaveUnitName']);
  if (slaveUnitName != null) {
    productStockAdjustRequest.slaveUnitName = slaveUnitName;
  }
  return productStockAdjustRequest;
}

Map<String, dynamic> $ProductStockAdjustRequestToJson(
    ProductStockAdjustRequest entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ledgerId'] = entity.ledgerId;
  data['productId'] = entity.productId;
  data['productName'] = entity.productName;
  data['unitType'] = entity.unitType;
  data['stock'] = entity.stock?.toJson();
  data['unitName'] = entity.unitName;
  data['masterStock'] = entity.masterStock?.toJson();
  data['masterUnitName'] = entity.masterUnitName;
  data['slaveStock'] = entity.slaveStock?.toJson();
  data['slaveUnitName'] = entity.slaveUnitName;
  return data;
}

extension ProductStockAdjustRequestExtension on ProductStockAdjustRequest {
  ProductStockAdjustRequest copyWith({
    int? ledgerId,
    int? productId,
    String? productName,
    int? unitType,
    Decimal? stock,
    String? unitName,
    Decimal? masterStock,
    String? masterUnitName,
    Decimal? slaveStock,
    String? slaveUnitName,
  }) {
    return ProductStockAdjustRequest()
      ..ledgerId = ledgerId ?? this.ledgerId
      ..productId = productId ?? this.productId
      ..productName = productName ?? this.productName
      ..unitType = unitType ?? this.unitType
      ..stock = stock ?? this.stock
      ..unitName = unitName ?? this.unitName
      ..masterStock = masterStock ?? this.masterStock
      ..masterUnitName = masterUnitName ?? this.masterUnitName
      ..slaveStock = slaveStock ?? this.slaveStock
      ..slaveUnitName = slaveUnitName ?? this.slaveUnitName;
  }
}