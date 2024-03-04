import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/order_product_detail_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class OrderProductDetail {
  int? orderId;
  int? productId;
  String? productName;
  String? productPlace;
  String? productStandard;
  int? unitType;
  int? unitGroupId;
  int? unitId;
  String? unitName;
  int? selectMasterUnit;
  int? masterUnitId;
  String? masterUnitName;
  int? slaveUnitId;
  String? slaveUnitName;
  Decimal? number;
  Decimal? masterNumber;
  Decimal? slaveNumber;
  Decimal? price;
  Decimal? masterPrice;
  Decimal? slavePrice;
  Decimal? totalAmount;

  OrderProductDetail();

  factory OrderProductDetail.fromJson(Map<String, dynamic> json) =>
      $OrderProductDetailFromJson(json);

  Map<String, dynamic> toJson() => $OrderProductDetailToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}