import 'package:decimal/decimal.dart';
import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/cost_income_detail_dto.g.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'dart:convert';

@JsonSerializable() //对应costIncomeDetail页面（总的）
class CostIncomeDetailDTO {
  int? id;
  int? ledgerId;
  int? orderType;
  int? discount;
  int? labelId;
  String? labelName;
  String? costIncomeName;
  Decimal? totalAmount;
  int? salesOrderId;
  String? salesOrderNo;
  int? salesOrderType;
  List<int>? productIdList;
  List<String>? productNameList;
  List<OrderPaymentDTO>? paymentDTOList;
  String? remark;
  DateTime? orderDate;
  int? invalid;
  int? creator;
  String? creatorName;
  DateTime? gmtCreate;

  CostIncomeDetailDTO();

  factory CostIncomeDetailDTO.fromJson(Map<String, dynamic> json) =>
      $CostIncomeDetailDTOFromJson(json);

  Map<String, dynamic> toJson() => $CostIncomeDetailDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
