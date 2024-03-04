import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_product_request.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class OrderProductRequest {
  int? productId;
  String? productName;
  Decimal? masterNumber;
  Decimal? slaveNumber;
  bool? selectUnit;
  int? groupUnitId;
  int? masterUnitId;
  int? slaveUnitId;
  Decimal? price;
  Decimal? totalAmount;

  OrderProductRequest();

  factory OrderProductRequest.fromJson(Map<String, dynamic> json) =>
      $OrderProductRequestFromJson(json);

  Map<String, dynamic> toJson() => $OrderProductRequestToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}