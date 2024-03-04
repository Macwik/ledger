import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/sales_money_statistic_dto.g.dart';
import 'package:ledger/entity/statistics/money_payment_dto.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()//销售资金统计
class SalesMoneyStatisticDTO {

  Decimal? totalSalesMoney;
  List<MoneyPaymentDTO>? paymentList;

  SalesMoneyStatisticDTO();

  factory SalesMoneyStatisticDTO.fromJson(Map<String, dynamic> json) =>
      $SalesMoneyStatisticDTOFromJson(json);

  Map<String, dynamic> toJson() => $SalesMoneyStatisticDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}