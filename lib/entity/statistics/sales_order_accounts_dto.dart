import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sales_order_accounts_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()//客户详情的统计
class SalesOrderAccountsDTO {
  int? id;
  int? ledgerId;
  int? orderType;
  int? orderId;
  int? customId;
  List<String>? productNameList;
  Decimal? totalAmount;
  Decimal? actualAmount;
  Decimal? creditAmount;
  Decimal? discountAmount;
  int? creator;
  String? creatorName;
  int? invalid;
  DateTime? gmtCreate;

  SalesOrderAccountsDTO();

  factory SalesOrderAccountsDTO.fromJson(Map<String, dynamic> json) =>
      $SalesOrderAccountsDTOFromJson(json);

  Map<String, dynamic> toJson() => $SalesOrderAccountsDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

}