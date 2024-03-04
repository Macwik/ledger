import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/product_sales_credit_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()
class ProductSalesCreditDTO {
  int? ledgerId;
  int? productId;
  String? productName;
  int? orderId;
  DateTime? gmtCreate;
  DateTime? orderDate;
  int? customerId;
  String? customerName;
  int? orderType;
  int? orderStatus;
  int? unitType;
  int? unitId;
  String? unitName;
  int? masterUnitId;
  String? masterUnitName;
  int? slaveUnitId;
  String? slaveUnitName;
  Decimal? number;
  Decimal? masterNumber;
  Decimal? slaveNumber;
  Decimal? totalAmount;
  Decimal? creditAmount;
  Decimal? repaymentAmount;


  ProductSalesCreditDTO();

  factory ProductSalesCreditDTO.fromJson(Map<String, dynamic> json) =>
      $ProductSalesCreditDTOFromJson(json);

  Map<String, dynamic> toJson() => $ProductSalesCreditDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}