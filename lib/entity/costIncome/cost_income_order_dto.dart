import 'package:decimal/decimal.dart';
import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/cost_income_order_dto.g.dart';
import 'dart:convert';

@JsonSerializable()//对应收入费用订单详情，Record页面
class CostIncomeOrderDTO {
  int? id;
  int? ledgerId;
  int? orderType;
  int? discount;
  int? labelId;
  String? labelName;
  String? costIncomeName;
  Decimal? totalAmount;
  List<int>? productIdList;
  List<String>? productNameList;
  int? creator;
  String? creatorName;
  int? invalid;
  DateTime? orderDate;
  DateTime? gmtCreate;

  CostIncomeOrderDTO();

  factory CostIncomeOrderDTO.fromJson(Map<String, dynamic> json) =>
      $CostIncomeOrderDTOFromJson(json);

  Map<String, dynamic> toJson() => $CostIncomeOrderDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
