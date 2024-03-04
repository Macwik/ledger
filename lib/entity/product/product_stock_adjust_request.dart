import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_stock_adjust_request.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class ProductStockAdjustRequest {
  int? ledgerId;
  int? productId;
  String ? productName;
  int? unitType;
  Decimal? stock;
  String ? unitName;
  Decimal? masterStock;
  String ? masterUnitName;
  Decimal? slaveStock;
  String ? slaveUnitName;

  ProductStockAdjustRequest({
    this.productId,
    this.unitType,
    this.productName,
    this.unitName,
    this.masterUnitName,
    this.slaveUnitName,
    this.stock,
    this.masterStock,
    this.slaveStock
});

factory
  ProductStockAdjustRequest.fromJson(Map<String, dynamic> json) =>
    $ProductStockAdjustRequestFromJson(json);
  Map<String, dynamic> toJson() => $ProductStockAdjustRequestToJson(this);

  @override
  String toString() {
  return jsonEncode(this);
}
}