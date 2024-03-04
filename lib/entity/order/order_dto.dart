import 'package:ledger/generated/json/base/json_field.dart';
import 'package:decimal/decimal.dart';
import 'package:ledger/generated/json/order_dto.g.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

@JsonSerializable()
class OrderDTO {//采购，销售开单分页展示
  int? id;
  int? ledgerId;
  String? orderNo;
  String? batchNo;
  List<String>? productNameList;
  int? customId;
  String? customName;
  Decimal? totalAmount;
  Decimal? creditAmount;
  Decimal? discountAmount;
  Decimal? repaymentDiscountAmount;//应该用不到
  DateTime? orderDate;
  int? orderStatus;
  int? orderType;
  int? invalid;
  int? creator;
  String? creatorName;
  DateTime? gmtCreate;

  OrderDTO();

  factory OrderDTO.fromJson(Map<String, dynamic> json) =>
      $OrderDTOFromJson(json);

  Map<String, dynamic> toJson() => $OrderDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}