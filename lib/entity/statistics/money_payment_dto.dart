import 'package:ledger/generated/json/base/json_field.dart';
import 'package:ledger/generated/json/money_payment_dto.g.dart';
import 'package:decimal/decimal.dart';
import 'dart:convert';

@JsonSerializable()//销售资金统计
class MoneyPaymentDTO {

  int? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodIcon;
  Decimal? salesAmount;
  Decimal? incomeAmount;
  Decimal? costAmount;
  Decimal? repaymentAmount;

  MoneyPaymentDTO();

  factory MoneyPaymentDTO.fromJson(Map<String, dynamic> json) =>
      $MoneyPaymentDTOFromJson(json);

  Map<String, dynamic> toJson() => $MoneyPaymentDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}